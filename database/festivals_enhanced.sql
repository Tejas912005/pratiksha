-- Virtual India - Enhanced Festival Calendar Schema (Safe Version)
-- This script safely adds columns only if they don't exist
-- Run this AFTER the main virtual_india.sql

USE virtual_india;

-- Check and add columns safely using procedure
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS AddColumnIfNotExists()
BEGIN
    -- Check for day_of_month column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'day_of_month') THEN
        ALTER TABLE festivals ADD COLUMN day_of_month INT DEFAULT NULL AFTER month;
    END IF;
    
    -- Check for history_en column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'history_en') THEN
        ALTER TABLE festivals ADD COLUMN history_en TEXT AFTER description_hi;
    END IF;
    
    -- Check for history_hi column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'history_hi') THEN
        ALTER TABLE festivals ADD COLUMN history_hi TEXT AFTER history_en;
    END IF;
    
    -- Check for rituals_en column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'rituals_en') THEN
        ALTER TABLE festivals ADD COLUMN rituals_en TEXT AFTER history_hi;
    END IF;
    
    -- Check for rituals_hi column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'rituals_hi') THEN
        ALTER TABLE festivals ADD COLUMN rituals_hi TEXT AFTER rituals_en;
    END IF;
    
    -- Check for food_en column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'food_en') THEN
        ALTER TABLE festivals ADD COLUMN food_en TEXT AFTER rituals_hi;
    END IF;
    
    -- Check for food_hi column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'food_hi') THEN
        ALTER TABLE festivals ADD COLUMN food_hi TEXT AFTER food_en;
    END IF;
    
    -- Check for dress_en column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'dress_en') THEN
        ALTER TABLE festivals ADD COLUMN dress_en TEXT AFTER food_hi;
    END IF;
    
    -- Check for dress_hi column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'dress_hi') THEN
        ALTER TABLE festivals ADD COLUMN dress_hi TEXT AFTER dress_en;
    END IF;
    
    -- Check for color column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'color') THEN
        ALTER TABLE festivals ADD COLUMN color VARCHAR(7) DEFAULT '#FF9933' AFTER dress_hi;
    END IF;
    
    -- Check for emoji column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'virtual_india' AND TABLE_NAME = 'festivals' AND COLUMN_NAME = 'emoji') THEN
        ALTER TABLE festivals ADD COLUMN emoji VARCHAR(10) DEFAULT '🎉' AFTER color;
    END IF;
END //
DELIMITER ;

-- Call the procedure
CALL AddColumnIfNotExists();

-- Drop the procedure after use
DROP PROCEDURE IF EXISTS AddColumnIfNotExists;

-- Now update existing festivals with detailed information (this is safe to run multiple times)
UPDATE festivals SET 
    day_of_month = 12,
    history_en = 'Diwali commemorates the return of Lord Rama to Ayodhya after 14 years of exile and his victory over Ravana. It symbolizes the spiritual victory of light over darkness, good over evil.',
    history_hi = 'दीवाली 14 साल के वनवास के बाद भगवान राम की अयोध्या वापसी और रावण पर उनकी जीत की याद में मनाई जाती है। यह अंधकार पर प्रकाश की आध्यात्मिक जीत का प्रतीक है।',
    rituals_en = 'Lighting diyas and candles, creating rangoli designs, performing Lakshmi Puja, bursting crackers, and exchanging gifts and sweets with family and friends.',
    rituals_hi = 'दीये और मोमबत्तियां जलाना, रंगोली बनाना, लक्ष्मी पूजा करना, पटाखे फोड़ना, और परिवार व दोस्तों के साथ उपहार और मिठाइयां बांटना।',
    food_en = 'Traditional sweets like Gulab Jamun, Jalebi, Kaju Katli, Ladoo, and savory snacks like Namak Pare, Chakli, and Mathri.',
    food_hi = 'गुलाब जामुन, जलेबी, काजू कतली, लड्डू जैसी पारंपरिक मिठाइयां और नमक पारे, चकली, मठरी जैसे नमकीन।',
    dress_en = 'New traditional clothes - women wear sarees or lehengas, men wear kurta-pajama or sherwanis. Gold jewelry is also customary.',
    dress_hi = 'नए पारंपरिक कपड़े - महिलाएं साड़ी या लहंगा पहनती हैं, पुरुष कुर्ता-पजामा या शेरवानी पहनते हैं। सोने के गहने भी प्रथागत हैं।',
    color = '#FFD700',
    emoji = '🪔'
WHERE name_en = 'Diwali';

UPDATE festivals SET 
    day_of_month = 14,
    history_en = 'Holi celebrates the legend of Prahlad and Holika, symbolizing the triumph of devotion over evil. It also marks the love of Radha and Krishna.',
    history_hi = 'होली प्रह्लाद और होलिका की कथा का जश्न मनाती है, जो बुराई पर भक्ति की जीत का प्रतीक है। यह राधा और कृष्ण के प्रेम को भी दर्शाती है।',
    rituals_en = 'Holika Dahan (bonfire) on the eve, playing with colors, water balloons, visiting friends, and enjoying festive foods and drinks like Thandai.',
    rituals_hi = 'होलिका दहन (अलाव), रंगों से खेलना, पानी के गुब्बारे, दोस्तों से मिलना, और ठंडाई जैसे उत्सव के भोजन और पेय का आनंद।',
    food_en = 'Gujiya, Malpua, Dahi Bhalla, Thandai (with or without bhang), Puran Poli, and various savory snacks.',
    food_hi = 'गुजिया, मालपुआ, दही भल्ला, ठंडाई (भांग के साथ या बिना), पूरन पोली, और विभिन्न नमकीन।',
    dress_en = 'White clothes that can be colored, old clothes that you do not mind getting stained with permanent colors.',
    dress_hi = 'सफेद कपड़े जिन पर रंग लग सकें, पुराने कपड़े जिन पर स्थायी रंग लगने से कोई फर्क न पड़े।',
    color = '#FF6B6B',
    emoji = '🎨'
WHERE name_en = 'Holi';

UPDATE festivals SET 
    day_of_month = 14,
    history_en = 'Pongal is a 4-day harvest festival thanking the Sun God and cattle for a bountiful harvest. The word Pongal means "to boil over".',
    history_hi = 'पोंगल 4 दिवसीय फसल उत्सव है जो अच्छी फसल के लिए सूर्य देव और मवेशियों को धन्यवाद देता है। पोंगल शब्द का अर्थ है "उबलना"।',
    rituals_en = 'Cooking Pongal dish in new pots until it overflows, decorating cattle, Kolam rangoli designs, and wearing new clothes.',
    rituals_hi = 'नए बर्तनों में पोंगल पकवान पकाना जब तक कि वह उबल न जाए, मवेशियों को सजाना, कोलम रंगोली, और नए कपड़े पहनना।',
    food_en = 'Sweet Pongal (rice with jaggery), Ven Pongal (savory rice), Vadai, Payasam, and sugarcane.',
    food_hi = 'मीठा पोंगल (गुड़ के साथ चावल), वेन पोंगल (नमकीन चावल), वड़ा, पायसम, और गन्ना।',
    dress_en = 'New traditional clothes like Pattu sarees for women and Veshti-Shirt for men.',
    dress_hi = 'महिलाओं के लिए पट्टु साड़ी और पुरुषों के लिए वेष्टी-शर्ट जैसे नए पारंपरिक कपड़े।',
    color = '#138808',
    emoji = '🌾'
WHERE name_en = 'Pongal';

UPDATE festivals SET 
    day_of_month = 15,
    history_en = 'Onam celebrates the return of the legendary King Mahabali, whose reign is considered the golden era of Kerala.',
    history_hi = 'ओणम पौराणिक राजा महाबली की वापसी का जश्न मनाता है, जिनका शासनकाल केरल का स्वर्ण युग माना जाता है।',
    rituals_en = 'Creating Pookalam (flower carpet), Vallam Kali (boat race), Pulikali (tiger dance), wearing traditional clothing.',
    rituals_hi = 'पूकलम (फूलों की कालीन) बनाना, वल्लम काली (नौका दौड़), पुली काली (बाघ नृत्य), पारंपरिक कपड़े पहनना।',
    food_en = 'Onam Sadya - a grand vegetarian feast with 26+ dishes served on banana leaf including Avial, Sambar, Payasam.',
    food_hi = 'ओणम सद्या - केले के पत्ते पर परोसा जाने वाला 26+ व्यंजनों का भव्य शाकाहारी भोज।',
    dress_en = 'Kasavu saree (cream with golden border) for women and Mundu (white dhoti) for men.',
    dress_hi = 'महिलाओं के लिए कसावु साड़ी और पुरुषों के लिए मुंडू (सफेद धोती)।',
    color = '#FFD700',
    emoji = '🏵️'
WHERE name_en = 'Onam';

UPDATE festivals SET 
    day_of_month = 1,
    history_en = 'Durga Puja celebrates Goddess Durgas victory over the buffalo demon Mahishasura.',
    history_hi = 'दुर्गा पूजा देवी दुर्गा की भैंस असुर महिषासुर पर विजय का जश्न मनाती है।',
    rituals_en = 'Pandal hopping, Dhunuchi dance, Sindoor Khela, offering Anjali, and immersion procession.',
    rituals_hi = 'पंडाल घूमना, धुनुची नृत्य, सिंदूर खेला, अंजलि चढ़ाना, और विसर्जन जुलूस।',
    food_en = 'Luchi with Aloor Dum, Kosha Mangsho, Mishti Doi, Sandesh, Rasgulla.',
    food_hi = 'लूची के साथ आलू दम, कोशा मांगशो, मिष्टी दोई, संदेश, रसगुल्ला।',
    dress_en = 'New sarees (red and white are traditional), Dhoti-Kurta for men.',
    dress_hi = 'नई साड़ियां (लाल और सफेद पारंपरिक हैं), पुरुषों के लिए धोती-कुर्ता।',
    color = '#DC143C',
    emoji = '🔱'
WHERE name_en = 'Durga Puja';

UPDATE festivals SET 
    day_of_month = 14,
    history_en = 'Ganesh Chaturthi celebrates the birth of Lord Ganesha, the elephant-headed god of wisdom.',
    history_hi = 'गणेश चतुर्थी भगवान गणेश के जन्म का जश्न मनाती है।',
    rituals_en = 'Installing Ganesha idol, performing puja for 10 days, offering Modak, and grand procession for immersion.',
    rituals_hi = 'गणेश प्रतिमा स्थापित करना, 10 दिनों तक पूजा करना, मोदक चढ़ाना, और विसर्जन के लिए भव्य जुलूस।',
    food_en = 'Modak (sweet dumplings), Puran Poli, Karanji, Ladoo.',
    food_hi = 'मोदक, पूरन पोली, करंजी, लड्डू।',
    dress_en = 'Traditional Maharashtrian attire - Nauvari saree for women and Dhoti-Kurta for men.',
    dress_hi = 'पारंपरिक महाराष्ट्रीय पोशाक।',
    color = '#FF6347',
    emoji = '🐘'
WHERE name_en = 'Ganesh Chaturthi';

UPDATE festivals SET 
    day_of_month = 1,
    history_en = 'Navratri celebrates nine forms of Goddess Durga representing divine feminine energy.',
    history_hi = 'नवरात्रि देवी दुर्गा के नौ रूपों का जश्न मनाती है।',
    rituals_en = 'Garba and Dandiya Raas dancing, fasting for 9 days, performing Kanya Puja.',
    rituals_hi = 'गरबा और डांडिया रास नृत्य, 9 दिनों का उपवास, कन्या पूजा करना।',
    food_en = 'Fasting foods like Sabudana Khichdi, Kuttu Puri, fruit salads.',
    food_hi = 'साबूदाना खिचड़ी, कुट्टू पूरी, फल सलाद जैसे व्रत के भोजन।',
    dress_en = 'Chaniya Choli for women and Kediyu-Dhoti for men in Gujarat.',
    dress_hi = 'गुजरात में महिलाओं के लिए चनिया चोली और पुरुषों के लिए केदियू-धोती।',
    color = '#9932CC',
    emoji = '💃'
WHERE name_en = 'Navratri';

UPDATE festivals SET 
    day_of_month = 13,
    history_en = 'Baisakhi marks the founding of the Khalsa Panth by Guru Gobind Singh in 1699.',
    history_hi = 'बैसाखी 1699 में गुरु गोबिंद सिंह द्वारा खालसा पंथ की स्थापना का प्रतीक है।',
    rituals_en = 'Visiting Gurdwaras, participating in Nagar Kirtan procession, performing Bhangra and Gidda.',
    rituals_hi = 'गुरुद्वारों में जाना, नगर कीर्तन जुलूस में भाग लेना, भांगड़ा और गिद्दा प्रदर्शन।',
    food_en = 'Makki Ki Roti, Sarson Ka Saag, Kheer, Lassi, Jalebi.',
    food_hi = 'मक्की की रोटी, सरसों का साग, खीर, लस्सी, जलेबी।',
    dress_en = 'Bright colored Salwar Kameez for women and Kurta-Pajama with Pagri for men.',
    dress_hi = 'महिलाओं के लिए चमकीले रंग की सलवार कमीज और पुरुषों के लिए पगड़ी के साथ कुर्ता-पजामा।',
    color = '#FF9933',
    emoji = '🌾'
WHERE name_en = 'Baisakhi';

UPDATE festivals SET 
    day_of_month = 14,
    history_en = 'Makar Sankranti marks the suns transition into Capricorn (Makar).',
    history_hi = 'मकर संक्रांति सूर्य के मकर राशि में संक्रमण का प्रतीक है।',
    rituals_en = 'Flying kites, taking holy dips in rivers, offering til-gud (sesame-jaggery).',
    rituals_hi = 'पतंग उड़ाना, नदियों में पवित्र स्नान, तिल-गुड़ चढ़ाना।',
    food_en = 'Til-Gud Ladoo, Chikki, Khichdi, Puran Poli, Gajak.',
    food_hi = 'तिल-गुड़ के लड्डू, चिक्की, खिचड़ी, पूरन पोली, गजक।',
    dress_en = 'Black clothes are worn in Maharashtra. Traditional attire varies by region.',
    dress_hi = 'महाराष्ट्र में काले कपड़े पहने जाते हैं।',
    color = '#FF9933',
    emoji = '🪁'
WHERE name_en = 'Makar Sankranti';

UPDATE festivals SET 
    day_of_month = 15,
    emoji = '🏵️',
    color = '#4169E1'
WHERE name_en = 'Bihu';

UPDATE festivals SET 
    day_of_month = 1,
    emoji = '🛕',
    color = '#FF6347'
WHERE name_en = 'Rath Yatra';

UPDATE festivals SET 
    day_of_month = 15,
    emoji = '🧵',
    color = '#FF69B4'
WHERE name_en = 'Raksha Bandhan';

-- Add Christmas (December 25) - Check if exists first
INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, day_of_month, region_id, color, emoji)
SELECT 'Christmas', 'क्रिसमस', 'Celebration of the birth of Jesus Christ, widely celebrated across India.', 'ईसा मसीह के जन्म का उत्सव।', 12, 25, NULL, '#228B22', '🎄'
WHERE NOT EXISTS (SELECT 1 FROM festivals WHERE name_en = 'Christmas');

-- Create reminder subscriptions table if not exists
CREATE TABLE IF NOT EXISTS festival_reminders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    festival_id INT,
    remind_days_before INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (festival_id) REFERENCES festivals(id)
);

SELECT 'Festival enhancement completed successfully!' AS Status;
