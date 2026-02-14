-- Complete Festival Details: History, Rituals, Food, Dress
-- Run this to update all festivals with detailed information

USE virtual_india;

-- Pongal
UPDATE festivals SET 
    history_en = 'Pongal is a 4-day harvest festival thanking the Sun God and cattle for a bountiful harvest. The word Pongal means "to boil over" symbolizing abundance.',
    rituals_en = 'Cooking Pongal dish in new pots until it overflows, decorating cattle with bells and garlands, creating Kolam rangoli designs, and wearing new clothes.',
    food_en = 'Sweet Pongal (rice with jaggery and milk), Ven Pongal (savory rice with pepper), Vadai, Payasam, sugarcane, and seasonal fruits.',
    dress_en = 'New traditional clothes - Pattu sarees in bright colors for women and Veshti with Shirt for men.'
WHERE name_en = 'Pongal';

-- Onam
UPDATE festivals SET 
    history_en = 'Onam celebrates the return of the legendary King Mahabali, whose reign is considered the golden era of Kerala. Lord Vishnu as Vamana blessed Mahabali with an annual return.',
    rituals_en = 'Creating Pookalam (flower carpet), Vallam Kali (snake boat race), Pulikali (tiger dance), Onasadya feast, and Kathakali performances.',
    food_en = 'Onam Sadya - a grand vegetarian feast with 26+ dishes on banana leaf: Avial, Sambar, Rasam, Thoran, Olan, Payasam, Banana chips, and Parippu curry.',
    dress_en = 'Kasavu saree (cream/white with golden border) for women and Mundu (white dhoti) with Shirt for men.'
WHERE name_en = 'Onam';

-- Durga Puja
UPDATE festivals SET 
    history_en = 'Durga Puja celebrates Goddess Durgas victory over the buffalo demon Mahishasura. It marks the homecoming of Goddess Durga with her children Lakshmi, Saraswati, Kartik, and Ganesha.',
    rituals_en = 'Pandal hopping to see artistic installations, Dhunuchi dance with incense, Sindoor Khela on Dashami, offering Anjali (prayers), and Bisarjan (immersion) procession.',
    food_en = 'Luchi with Aloor Dum, Kosha Mangsho (mutton curry), Chingri Malai Curry, Mishti Doi, Sandesh, Rasgulla, and Rosogolla.',
    dress_en = 'New sarees (red and white traditional), silk sarees with zari work, Dhoti-Kurta for men with Punjabi tops.'
WHERE name_en = 'Durga Puja';

-- Ganesh Chaturthi
UPDATE festivals SET 
    history_en = 'Ganesh Chaturthi celebrates the birth of Lord Ganesha, the elephant-headed god of wisdom and new beginnings. Lokmanya Tilak popularized it as a public celebration during the freedom movement.',
    rituals_en = 'Installing decorated Ganesha idol at home/pandals, performing daily puja for 10 days, offering 21 Modaks and Durva grass, chanting mantras, and grand Visarjan procession.',
    food_en = 'Modak (sweet dumplings - Ganeshas favorite), Puran Poli, Karanji, Ladoo, Shrikhand, and Ukdiche Modak (steamed modaks).',
    dress_en = 'Traditional Maharashtrian attire - Nauvari saree (9-yard saree) for women and Dhoti-Kurta with Pheta (turban) for men.'
WHERE name_en = 'Ganesh Chaturthi';

-- Navratri
UPDATE festivals SET 
    history_en = 'Navratri celebrates nine forms of Goddess Durga representing divine feminine energy (Shakti). Each night is dedicated to one avatar: Shailaputri, Brahmacharini, Chandraghanta, Kushmanda, Skandamata, Katyayani, Kalaratri, Mahagauri, and Siddhidatri.',
    rituals_en = 'Garba and Dandiya Raas dancing in circles, fasting for 9 days, performing Kanya Puja on Ashtami, wearing specific colors each day, and setting up Kalash/Ghat.',
    food_en = 'Fasting foods: Sabudana Khichdi, Kuttu Ki Puri, Singhare Ka Halwa, Samak Rice, fruits, milk, and curd. Feast on Navami with Halwa-Puri-Chana.',
    dress_en = 'Chaniya Choli (lehenga) for women and Kediyu-Dhoti for men in Gujarat. Each day has a specific color: white, red, royal blue, yellow, green, grey, orange, peacock green, pink.'
WHERE name_en = 'Navratri';

-- Baisakhi
UPDATE festivals SET 
    history_en = 'Baisakhi marks the founding of the Khalsa Panth by Guru Gobind Singh in 1699 and celebrates the harvest season in Punjab. It also marks the Punjabi and Sikh New Year.',
    rituals_en = 'Visiting Gurdwaras especially Golden Temple, participating in Nagar Kirtan procession, performing energetic Bhangra and Gidda, community Langar (free meal), and fairs.',
    food_en = 'Makki Ki Roti with Sarson Ka Saag, Kheer, Lassi, Jalebi, Chole Bhature, Kadhi Pakora, and traditional Punjabi sweets.',
    dress_en = 'Bright colored Salwar Kameez or Patiala suits for women, Kurta-Pajama with colorful Pagri (turban) for men.'
WHERE name_en = 'Baisakhi';

-- Makar Sankranti
UPDATE festivals SET 
    history_en = 'Makar Sankranti marks the suns transition into Capricorn (Makar Rashi) and the beginning of longer days. It is one of the few Hindu festivals based on the solar calendar.',
    rituals_en = 'Flying colorful kites, taking holy dips in rivers like Ganges, offering til-gud (sesame-jaggery) with "Til-gul ghya god god bola", bonfires, and cattle worship.',
    food_en = 'Til-Gud Ladoo (sesame-jaggery balls), Chikki (peanut brittle), Khichdi, Puran Poli, Pongal, Gajak, and Rewri.',
    dress_en = 'Black clothes are worn in Maharashtra to absorb suns warmth. In other regions, traditional colorful attire is worn.'
WHERE name_en = 'Makar Sankranti';

-- Bihu
UPDATE festivals SET 
    history_en = 'Bihu is the Assamese New Year celebration marking the harvest season. Three Bihus are celebrated: Bohag Bihu (spring), Kati Bihu (autumn), and Magh Bihu (winter harvest).',
    rituals_en = 'Traditional Bihu dance in circles, Husori (folk songs), building Meji (bonfire), community feasts, exchanging Gamosa (traditional cloth), and buffalo fights.',
    food_en = 'Pitha (rice cakes), Laru (coconut ladoo), Jolpan (snacks with flattened rice), Duck curry, Fish preparations, and rice beer.',
    dress_en = 'Mekhela Chador (traditional Assamese saree) for women and Dhoti-Gamosa for men. Red and gold colors are preferred.'
WHERE name_en = 'Bihu';

-- Raksha Bandhan
UPDATE festivals SET 
    history_en = 'Raksha Bandhan celebrates the bond between brothers and sisters. The legend tells of Queen Karnavati sending a rakhi to Emperor Humayun seeking protection. "Raksha" means protection, "Bandhan" means bond.',
    rituals_en = 'Sisters tie sacred thread (rakhi) on brothers wrist, apply tilak, perform aarti, feed sweets. Brothers give gifts and promise protection.',
    food_en = 'Sweets like Barfi, Peda, Gulab Jamun, Kaju Katli, and home-cooked favorite dishes of brothers.',
    dress_en = 'New traditional clothes - women in sarees or suits, men in kurta-pajama. Bright festive colors are preferred.'
WHERE name_en = 'Raksha Bandhan';

-- Rath Yatra
UPDATE festivals SET 
    history_en = 'Rath Yatra in Puri, Odisha is the annual chariot festival of Lord Jagannath, along with siblings Balabhadra and Subhadra. The word Juggernaut comes from Jagannath.',
    rituals_en = 'Pulling massive decorated chariots through streets, Chhera Pahanra (King sweeps the chariot), millions of devotees participate, deities visit Gundicha Temple for 9 days.',
    food_en = 'Mahaprasad of Jagannath Temple - 56 varieties of offerings including Khechudi, Dalma, Saga Bhaja, Rasagola, and Khiri.',
    dress_en = 'Traditional Odia attire - Saree for women and Dhoti for men. Many wear yellow/saffron colored clothes.'
WHERE name_en = 'Rath Yatra';

-- New festivals with complete details

-- Maha Shivaratri
UPDATE festivals SET 
    history_en = 'Maha Shivaratri marks the night when Lord Shiva performed the Tandava, the cosmic dance of creation, preservation, and destruction. It is also believed to be the night of his marriage to Goddess Parvati.',
    rituals_en = 'Night-long vigil (Jagaran), fasting, offering Bel leaves to Shiv Lingam, Abhishek with milk/water/honey, chanting Om Namah Shivaya, and visiting Shiva temples.',
    food_en = 'Fasting foods - fruits, milk, Thandai, Sabudana Khichdi. After fast: Pakoras, Halwa, and special feast.',
    dress_en = 'Simple white or saffron clothes for temple visits. Many wear Rudraksha beads.'
WHERE name_en = 'Maha Shivaratri';

-- Vasant Panchami
UPDATE festivals SET 
    history_en = 'Vasant Panchami marks the arrival of spring and honors Goddess Saraswati, the deity of knowledge, music, and arts. It is also the day Goddess Saraswati was born.',
    rituals_en = 'Worshipping Goddess Saraswati, wearing yellow clothes, placing books and instruments near the deity, flying kites, and starting new educational pursuits.',
    food_en = 'Yellow-colored foods: Kesari Halwa, Yellow Rice, Boondi Ladoo, Saffron Kheer, and Mango.',
    dress_en = 'Yellow clothes symbolizing mustard fields and the vibrancy of spring.'
WHERE name_en = 'Vasant Panchami';

-- Buddha Purnima
UPDATE festivals SET 
    history_en = 'Buddha Purnima commemorates three significant events: Buddhas birth in Lumbini, enlightenment under Bodhi tree in Bodh Gaya, and Mahaparinirvana in Kushinagar.',
    rituals_en = 'Visiting Buddhist temples/monasteries, meditation, Bodhi tree worship, chanting sutras, lighting lamps, releasing caged birds, and practicing acts of kindness.',
    food_en = 'Vegetarian food only, Kheer (Buddhas favorite before enlightenment), fruits, rice, and simple meals.',
    dress_en = 'White or simple traditional clothes symbolizing purity and peace.'
WHERE name_en = 'Buddha Purnima';

-- Chhath Puja
UPDATE festivals SET 
    history_en = 'Chhath Puja is one of the most ancient Hindu festivals, dedicated to Sun God Surya and Chhathi Maiya (consort of Surya). It thanks the Sun for sustaining life on earth.',
    rituals_en = '36-hour Nirjala Vrat (fast without water), standing in water at sunrise and sunset, offering Arghya to Sun with fruits and Thekua, Soop (bamboo tray) rituals.',
    food_en = 'Thekua (wheat sweet), Kheer, fruits (coconut, banana, sugarcane), Kasar, and Prasad prepared without onion-garlic.',
    dress_en = 'New traditional clothes without stitches for women (saree), Dhoti-Kurta for men. No footwear during rituals.'
WHERE name_en = 'Chhath Puja';

-- Guru Nanak Jayanti
UPDATE festivals SET 
    history_en = 'Guru Nanak Jayanti celebrates the birth of Guru Nanak Dev Ji (1469), the founder of Sikhism and first of the ten Sikh Gurus. He preached equality, service, and devotion to one God.',
    rituals_en = 'Prabhat Pheris (early morning processions), Akhand Path (48-hour continuous reading of Guru Granth Sahib), Langar (community meal), and Nagar Kirtan.',
    food_en = 'Langar food: Dal, Roti, Rice, Kheer, Kadhi, vegetables. Special Kada Prasad (sweet semolina halwa).',
    dress_en = 'Traditional Punjabi attire in saffron or white. Many wear saffron turbans.'
WHERE name_en = 'Guru Nanak Jayanti';

-- Lohri  
UPDATE festivals SET 
    history_en = 'Lohri marks the end of winter and celebrates the harvest of Rabi crops, especially sugarcane. It is particularly significant for newlyweds and new borns.',
    rituals_en = 'Lighting bonfire, circumambulating fire, throwing rewri/popcorn/peanuts into fire, singing Lohri songs, Bhangra and Gidda dance.',
    food_en = 'Rewri, Gajak, Peanuts, Popcorn, Til (sesame) sweets, Sarson Ka Saag, Makki Ki Roti, and Jaggery.',
    dress_en = 'Bright Punjabi attire - Phulkari dupattas for women, bright kurtas for men.'
WHERE name_en = 'Lohri';

-- Ram Navami
UPDATE festivals SET 
    history_en = 'Ram Navami celebrates the birth of Lord Rama, the seventh avatar of Lord Vishnu, born to King Dasharatha and Queen Kausalya in Ayodhya.',
    rituals_en = 'Fasting, visiting Ram temples, reading Ramayana, decorating Ram idols, Rath Yatras, and feeding the poor.',
    food_en = 'Fasting foods: fruits, Panchamrit, Kheer. After fast: Puri, Halwa, Chana, and sweets.',
    dress_en = 'Traditional clothes, many wear yellow or saffron colored attire.'
WHERE name_en = 'Ram Navami';

-- Hanuman Jayanti
UPDATE festivals SET 
    history_en = 'Hanuman Jayanti celebrates the birth of Lord Hanuman, the devoted disciple of Lord Rama known for his strength, courage, and unwavering devotion.',
    rituals_en = 'Visiting Hanuman temples, reciting Hanuman Chalisa, offering sindoor and oil, fasting, and distributing prasad.',
    food_en = 'Prasad items: Ladoo (especially Boondi Ladoo), fruits, Panchamrit, and sweets.',
    dress_en = 'Simple traditional clothes, many wear saffron or red.'
WHERE name_en = 'Hanuman Jayanti';

-- Mahavir Jayanti
UPDATE festivals SET 
    history_en = 'Mahavir Jayanti celebrates the birth of Vardhamana Mahavira, the 24th and last Tirthankara of Jainism, who taught the principles of Ahimsa (non-violence).',
    rituals_en = 'Abhishek (ceremonial bath) of Mahavira idol, temple visits, processions with Mahaviras image, meditation, and charitable activities.',
    food_en = 'Strictly vegetarian Jain food without root vegetables, onion, garlic. Sweets and fruits.',
    dress_en = 'White traditional clothes symbolizing purity and non-violence.'
WHERE name_en = 'Mahavir Jayanti';

-- Karva Chauth
UPDATE festivals SET 
    history_en = 'Karva Chauth is a day-long fast observed by married Hindu women for the longevity and well-being of their husbands. The fast is broken after sighting the moon.',
    rituals_en = 'Sargi (pre-dawn meal by mother-in-law), day-long Nirjala fast, applying Mehendi, evening puja with Karva, sighting moon through sieve, husband offers water.',
    food_en = 'Sargi: Feni, fruits, sweets, mathri. After fast: favorite foods, Kheer, Puri, and special dinner.',
    dress_en = 'Solah Shringar (16 adornments) including red/pink saree or lehenga, bangles, sindoor, bindhi, and jewelry.'
WHERE name_en = 'Karva Chauth';

-- Teej
UPDATE festivals SET 
    history_en = 'Teej celebrates the union of Lord Shiva and Goddess Parvati. It is observed by married women for their husbands well-being and by unmarried girls to get a good husband.',
    rituals_en = 'Fasting, applying Mehendi, swinging on decorated swings, wearing green clothes, singing folk songs, and Parvati puja.',
    food_en = 'Ghewar (Rajasthani sweet), Malpua, Kheer, Puri, and fasting foods before breaking fast.',
    dress_en = 'Green lehengas, sarees, or suits with traditional jewelry. Green bangles and Mehendi are essential.'
WHERE name_en = 'Teej';

-- Guru Purnima
UPDATE festivals SET 
    history_en = 'Guru Purnima honors teachers and gurus who guide us on the path of knowledge. It is also the birth anniversary of Ved Vyasa who compiled the Vedas.',
    rituals_en = 'Honoring teachers with gifts and gratitude, visiting ashrams, meditation, reading scriptures, and Guru Puja.',
    food_en = 'Offering favorite foods to guru, simple vegetarian meals, Kheer, and sweets.',
    dress_en = 'Simple traditional clothes, preferably white or saffron.'
WHERE name_en = 'Guru Purnima';

-- Dussehra/Vijayadashami
UPDATE festivals SET 
    history_en = 'Dussehra celebrates the victory of Lord Rama over Ravana and Goddess Durgas victory over Mahishasura. It symbolizes good over evil.',
    rituals_en = 'Ramlila performances, burning giant effigies of Ravana, Meghnath, Kumbhakaran, Shastra Puja (weapon worship), and Durga idol immersion.',
    food_en = 'Jalebi, Fafda (in Gujarat), Poha, sweets, and feast after Dussehra.',
    dress_en = 'New traditional clothes, festive attire in bright colors.'
WHERE name_en = 'Dussehra/Vijayadashami';

-- Dhanteras
UPDATE festivals SET 
    history_en = 'Dhanteras marks the first day of Diwali celebrations. Dhan means wealth. It is believed that Goddess Lakshmi emerged from the ocean on this day during Samudra Manthan.',
    rituals_en = 'Buying gold, silver, utensils, and new items, cleaning and decorating homes, lighting Diyas, Lakshmi-Ganesha puja.',
    food_en = 'Sweets, dry fruits, and light snacks as preparation for Diwali begins.',
    dress_en = 'New traditional clothes, gold jewelry.'
WHERE name_en = 'Dhanteras';

-- Christmas
UPDATE festivals SET 
    history_en = 'Christmas celebrates the birth of Jesus Christ in Bethlehem. In India, it is celebrated with unique Indian traditions blended with Western customs, especially in Goa, Kerala, and Northeast.',
    rituals_en = 'Midnight Mass in churches, decorating Christmas trees, exchanging gifts, carol singing, crib displays, and community feasts.',
    food_en = 'Christmas cake, plum pudding, roasted turkey/chicken, wine, kulkuls, neureos, and rose cookies.',
    dress_en = 'New clothes in red, green, and white. Western formals for church services.'
WHERE name_en = 'Christmas';

-- Republic Day
UPDATE festivals SET 
    history_en = 'Republic Day celebrates the adoption of the Indian Constitution on January 26, 1950, when India became a sovereign republic. Dr. B.R. Ambedkar was the chief architect.',
    rituals_en = 'Grand parade at Rajpath Delhi showcasing military might and cultural heritage, flag hoisting ceremonies, cultural programs, and award ceremonies.',
    food_en = 'Community meals, sweets distribution, and patriotic-themed foods.',
    dress_en = 'Tricolor theme clothing - saffron, white, green. Formal attire for official ceremonies.'
WHERE name_en = 'Republic Day';

-- Independence Day
UPDATE festivals SET 
    history_en = 'Independence Day celebrates Indias freedom from British colonial rule on August 15, 1947. Jawaharlal Nehru hoisted the first tricolor at Red Fort.',
    rituals_en = 'Flag hoisting at Red Fort by Prime Minister, parades, patriotic songs, kite flying, cultural programs, and remembering freedom fighters.',
    food_en = 'Tricolor-themed sweets and snacks, traditional Indian cuisine.',
    dress_en = 'White clothes with tricolor accessories, traditional Indian wear.'
WHERE name_en = 'Independence Day';

SELECT 'All festival details added successfully!' AS Status;
