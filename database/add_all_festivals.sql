-- Complete Indian Festival Data for All 12 Months
-- Run this to add festivals for months that were missing

USE virtual_india;

-- February Festivals
INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji, history_en, rituals_en, food_en, dress_en)
SELECT 'Maha Shivaratri', 'महाशिवरात्रि', 
'The Great Night of Lord Shiva, celebrating the cosmic dance of creation, preservation, and destruction.', 
'भगवान शिव की महान रात्रि, सृष्टि, संरक्षण और विनाश के ब्रह्मांडीय नृत्य का जश्न।',
2, 18, NULL, '#4B0082', '🔱',
'Maha Shivaratri marks the night when Lord Shiva performed the Tandava, the cosmic dance. It is also believed to be the night of his marriage to Goddess Parvati.',
'Night-long vigil and fasting, offering Bel leaves to Shiv Lingam, chanting Om Namah Shivaya, visiting Shiva temples.',
'Fasting foods like fruits, milk, and Thandai. Breaking fast with Sabudana dishes.',
'Simple white or saffron clothes for temple visits.'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Maha Shivaratri');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Vasant Panchami', 'वसंत पंचमी', 
'Festival marking the arrival of spring and honoring Goddess Saraswati, the goddess of knowledge and arts.', 
'वसंत के आगमन और ज्ञान और कला की देवी सरस्वती का सम्मान करने वाला त्योहार।',
2, 5, NULL, '#FFD700', '📚'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Vasant Panchami');

-- May Festivals
INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji, history_en, rituals_en, food_en, dress_en)
SELECT 'Buddha Purnima', 'बुद्ध पूर्णिमा', 
'Celebrates the birth, enlightenment, and death of Gautama Buddha, the founder of Buddhism.', 
'गौतम बुद्ध के जन्म, ज्ञान प्राप्ति और महापरिनिर्वाण का उत्सव।',
5, 23, NULL, '#FFD700', '☸️',
'Buddha Purnima commemorates three significant events in Buddhas life - his birth in Lumbini, his enlightenment under the Bodhi tree in Bodh Gaya, and his Mahaparinirvana in Kushinagar.',
'Visiting Buddhist temples and monasteries, meditation, offering prayers, lighting lamps, and practicing acts of kindness.',
'Vegetarian food, Kheer, fruits, and simple meals.',
'White or simple traditional clothes.'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Buddha Purnima');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Akshaya Tritiya', 'अक्षय तृतीया', 
'Auspicious day for new beginnings, buying gold, and starting new ventures believed to bring success.', 
'नई शुरुआत, सोना खरीदने और नए उद्यम शुरू करने का शुभ दिन।',
5, 10, NULL, '#FFD700', '✨'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Akshaya Tritiya');

-- June Festivals
INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji, history_en, rituals_en, food_en, dress_en)
SELECT 'Ganga Dussehra', 'गंगा दशहरा', 
'Celebrates the descent of River Ganga from heaven to earth, observed with holy dips in the Ganges.', 
'स्वर्ग से पृथ्वी पर गंगा नदी के अवतरण का उत्सव।',
6, 16, NULL, '#4169E1', '🌊',
'The festival commemorates the day when Goddess Ganga descended from heaven to earth following the penance of King Bhagiratha to liberate his ancestors.',
'Taking holy dips in the Ganges, performing Ganga Aarti, offering prayers, floating diyas on the river.',
'Fasting foods and Prasad, fruits and sweets.',
'Simple white or traditional clothes for bathing in the river.'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Ganga Dussehra');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Jagannath Rath Yatra', 'जगन्नाथ रथ यात्रा', 
'Grand chariot festival of Lord Jagannath celebrated with massive processions in Puri.', 
'भगवान जगन्नाथ का भव्य रथ उत्सव।',
6, 20, 3, '#FF6347', '🛕'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Jagannath Rath Yatra');

-- November Festivals  
INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji, history_en, rituals_en, food_en, dress_en)
SELECT 'Chhath Puja', 'छठ पूजा', 
'Ancient Hindu festival dedicated to Sun God and Chhathi Maiya, celebrated mainly in Bihar and Eastern UP.', 
'सूर्य देव और छठी मैया को समर्पित प्राचीन हिंदू त्योहार।',
11, 7, 3, '#FF9933', '☀️',
'Chhath Puja is one of the most ancient festivals, dedicated to the Sun God Surya and Chhathi Maiya. It thanks the Sun for sustaining life on earth.',
'36-hour fast without water, standing in water during sunrise and sunset, offering Arghya to Sun God, Thekua prasad preparation.',
'Thekua (wheat sweet), Kheer, fruits, coconut, sugarcane, and prasad.',
'New traditional clothes - women wear sarees without stitches.'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Chhath Puja');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Guru Nanak Jayanti', 'गुरु नानक जयंती', 
'Birth anniversary of Guru Nanak Dev Ji, the founder of Sikhism, celebrated with prayers and Langar.', 
'सिख धर्म के संस्थापक गुरु नानक देव जी की जयंती।',
11, 15, 1, '#FF9933', '🪯'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Guru Nanak Jayanti');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Kartik Purnima', 'कार्तिक पूर्णिमा', 
'Sacred full moon day with holy dips in rivers and Dev Diwali celebrations in Varanasi.', 
'पवित्र पूर्णिमा का दिन, नदियों में पवित्र स्नान और वाराणसी में देव दीवाली।',
11, 27, NULL, '#FFD700', '🌕'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Kartik Purnima');

-- Update existing festivals with better data
UPDATE festivals SET 
    day_of_month = 1,
    color = '#4169E1',
    emoji = '🏵️'
WHERE name_en = 'Rath Yatra' AND day_of_month IS NULL;

-- Add more festivals for sparse months
INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Lohri', 'लोहड़ी', 
'Punjabi harvest festival celebrated with bonfires, dancing, and traditional foods.', 
'पंजाबी फसल उत्सव, अलाव, नृत्य और पारंपरिक भोजन के साथ मनाया जाता है।',
1, 13, 1, '#FF6347', '🔥'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Lohri');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Guru Gobind Singh Jayanti', 'गुरु गोबिंद सिंह जयंती', 
'Birth anniversary of Guru Gobind Singh Ji, the tenth Sikh Guru.', 
'दसवें सिख गुरु, गुरु गोबिंद सिंह जी की जयंती।',
1, 5, 1, '#FF9933', '⚔️'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Guru Gobind Singh Jayanti');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Mahavir Jayanti', 'महावीर जयंती', 
'Birth anniversary of Lord Mahavira, the 24th Tirthankara of Jainism.', 
'जैन धर्म के 24वें तीर्थंकर भगवान महावीर की जयंती।',
4, 21, NULL, '#FFD700', '☸️'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Mahavir Jayanti');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Ram Navami', 'राम नवमी', 
'Birth anniversary of Lord Rama, the seventh avatar of Vishnu.', 
'भगवान विष्णु के सातवें अवतार, भगवान राम की जयंती।',
4, 17, NULL, '#FF9933', '🏹'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Ram Navami');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Hanuman Jayanti', 'हनुमान जयंती', 
'Birth anniversary of Lord Hanuman, celebrated with prayers and recitation of Hanuman Chalisa.', 
'भगवान हनुमान की जयंती, प्रार्थना और हनुमान चालीसा के पाठ के साथ मनाई जाती है।',
4, 6, NULL, '#FF6347', '🐒'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Hanuman Jayanti');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Teej', 'तीज', 
'Festival for married women celebrating the union of Shiva and Parvati with fasting and swings.', 
'विवाहित महिलाओं का त्योहार, शिव और पार्वती के मिलन का उत्सव।',
7, 19, 1, '#228B22', '🎋'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Teej');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Guru Purnima', 'गुरु पूर्णिमा', 
'Day to honor teachers and gurus, celebrating the importance of knowledge and wisdom.', 
'शिक्षकों और गुरुओं का सम्मान करने का दिन।',
7, 3, NULL, '#9932CC', '🙏'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Guru Purnima');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Karva Chauth', 'करवा चौथ', 
'Festival where married women fast for the long life and well-being of their husbands.', 
'विवाहित महिलाएं अपने पति की लंबी उम्र के लिए व्रत रखती हैं।',
10, 20, 1, '#DC143C', '🌙'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Karva Chauth');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Dussehra/Vijayadashami', 'दशहरा/विजयादशमी', 
'Victory of good over evil - Ram over Ravana in North, Durga over Mahishasura in East.', 
'बुराई पर अच्छाई की जीत - राम की रावण पर विजय।',
10, 12, NULL, '#FF6347', '🏹'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Dussehra/Vijayadashami');

INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Dhanteras', 'धनतेरस', 
'First day of Diwali celebrations, auspicious for buying gold, silver, and new items.', 
'दिवाली उत्सव का पहला दिन, सोना, चांदी खरीदने का शुभ दिन।',
10, 10, NULL, '#FFD700', '💰'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Dhanteras');

SELECT 'All festivals added successfully!' AS Status;
