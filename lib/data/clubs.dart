import 'package:clients_digcoach/data/amenities.dart';
import 'package:clients_digcoach/data/coaches.dart';
import 'package:clients_digcoach/data/courts.dart';
import 'package:clients_digcoach/data/days.dart';
import 'package:clients_digcoach/data/reservations.dart';
import 'package:clients_digcoach/models/club/club.dart';
import 'package:clients_digcoach/models/club/general_info.dart';
import 'package:clients_digcoach/models/club/holiday.dart';
import 'package:clients_digcoach/models/club/opening_hours.dart';
import 'package:clients_digcoach/models/club/opening_time.dart';
import 'package:clients_digcoach/models/court.dart';
import 'package:clients_digcoach/models/days.dart';

List<Club> clubs = [
  Club(
    id: '1',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
    openingHours: days,
    generalInfo: const GeneralInfo(
      id: '1',
      name: 'club 1',
      ceoName: 'ceo',
      surname: 'sur name ceo',
      phone: 'phone',
      description: 'description',
      street: 'street',
      city: 'city',
      country: 'country',
      postalCode: 'postalCode',
      url: 'url',
      email: 'email',
      instagram: 'instagram',
      facebook: 'facebook',
      tiktok: 'tiktok',
      twitter: 'twitter',
      images: [],
    ),
    holidays: [],
    amenities: [],
  ),
  Club(
    id: '2',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
    openingHours: days,
    generalInfo: const GeneralInfo(
      id: '2',
      name: 'club 2',
      ceoName: 'ceo',
      surname: 'sur name ceo',
      phone: 'phone',
      description: 'description',
      street: 'street',
      city: 'city',
      country: 'country',
      postalCode: 'postalCode',
      url: 'url',
      email: 'email',
      instagram: 'instagram',
      facebook: 'facebook',
      tiktok: 'tiktok',
      twitter: 'twitter',
      images: [],
    ),
    holidays: [],
    amenities: [],
  ),
  Club(
    id: '3',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
    openingHours: days,
    generalInfo: const GeneralInfo(
      id: '3',
      name: 'club 3',
      ceoName: 'ceo',
      surname: 'sur name ceo',
      phone: 'phone',
      description: 'description',
      street: 'street',
      city: 'city',
      country: 'country',
      postalCode: 'postalCode',
      url: 'url',
      email: 'email',
      instagram: 'instagram',
      facebook: 'facebook',
      tiktok: 'tiktok',
      twitter: 'twitter',
      images: [],
    ),
    holidays: [],
    amenities: [],
  ),
];

Club defaultClub({required int clubId}) => Club(
      id: '$clubId',
      coaches: [],
      courts: [
        Court(
          id: '1',
          clubId: '$clubId',
          name: 'Court 1',
          description: '',
          courtNumber: 1,
        ),
      ],
      reservations: [],
      openingHours: List.generate(
        Days.values.length,
        (index) {
          final day = Days.values[index];
          final isWeekday =
              index >= Days.monday.index && index <= Days.friday.index;

          return OpeningHours(
            day: day,
            times: [
              if (isWeekday) OpeningTime.standard(),
            ],
          );
        },
      ),
      generalInfo: GeneralInfo(
        id: '$clubId',
        name: 'Club $clubId',
        ceoName: '',
        surname: '',
        phone: '',
        description: '',
        street: '',
        city: '',
        country: '',
        postalCode: '',
        url: '',
        email: '',
        instagram: '',
        facebook: '',
        tiktok: '',
        twitter: '',
        images: [],
      ),
      holidays: List.generate(1, (index) => Holiday.standard()),
      amenities: List.from(defaultAmenities),
    );
