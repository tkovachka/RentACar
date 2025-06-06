const functions = require('firebase-functions');
const admin = require('firebase-admin');
const fetch = require('node-fetch');
const { defineString  } = require('firebase-functions/params');


admin.initializeApp();

const accessKey = defineString('UNSPLASH_ACCESS_KEY');

exports.fetchAndStoreCars = functions.https.onRequest(async (req, res) => {
  try {
    const carApiUrl = 'https://carapi.app/api/trims?limit=15&verbose=yes&year=2019';
    const carApiResponse = await fetch(carApiUrl);
    const carApiData = await carApiResponse.json();
    const cars = carApiData.data;

    const unsplashAccessKey = accessKey.value();

    const db = admin.firestore();

    for (const car of cars) {
      const brand = car.make_model.make.name;
      const model = car.make_model.name;
      const query = `${brand} ${model} car`;
      const unsplashUrl = `https://api.unsplash.com/search/photos?query=${encodeURIComponent(query)}&client_id=${unsplashAccessKey}`;

      const unsplashResponse = await fetch(unsplashUrl);
      const unsplashData = await unsplashResponse.json();

      let imageUrl = '';

      if(unsplashData.results && unsplashData.results.length > 0){
        const randomIndex = Math.floor(Math.random() * unsplashData.results.length);
        const randomImage = unsplashData.results[randomIndex];
        imageUrl = randomImage.urls?.small || '';
      } else {
        console.warn(`No Unsplash image found for query: "${query}"`);
      }

      const trimId = car.id;
      const trimDetailUrl = `https://carapi.app/api/trims/${trimId}`;
      const trimDetailResponse = await fetch(trimDetailUrl);
      const trimDetailData = await trimDetailResponse.json();

      const carData = {
        brand: brand,
        model: model,
        year: trimDetailData.year,
        description: trimDetailData.description,
        type: trimDetailData.make_model_trim_body.type,
        seats: trimDetailData.make_model_trim_body.seats,
        fuelType: trimDetailData.make_model_trim_engine.fuel_type,
        transmission: trimDetailData.make_model_trim_engine.transmission,
        cargoCapacity: parseFloat(trimDetailData.make_model_trim_body.cargo_capacity),
        pricePerDay: Math.floor(Math.random() * (400 - 50 + 1)) + 50,
        imageUrl: imageUrl,
      };

      await db.collection('cars').add(carData);
    }

    res.status(200).send('Cars fetched and stored successfully.');
  } catch (error) {
    console.error('Error fetching and storing cars:', error);
    res.status(500).send(error);
  }
});
