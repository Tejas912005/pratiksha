-- Virtual India Database Schema
-- A Digital Platform to Explore Indian Heritage & Culture

CREATE DATABASE IF NOT EXISTS virtual_india;
USE virtual_india;

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    language_pref ENUM('en', 'hi') DEFAULT 'en',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Regions Table (North, South, East, West)
CREATE TABLE regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name_en VARCHAR(50) NOT NULL,
    name_hi VARCHAR(50) NOT NULL,
    description_en TEXT,
    description_hi TEXT,
    image_url VARCHAR(255),
    states_en TEXT,
    states_hi TEXT
);

-- Cultural Items (Art, Dance, Craft)
CREATE TABLE cultural_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    region_id INT,
    category ENUM('art', 'dance', 'craft', 'music', 'cuisine') NOT NULL,
    name_en VARCHAR(100) NOT NULL,
    name_hi VARCHAR(100),
    description_en TEXT,
    description_hi TEXT,
    image_url VARCHAR(255),
    FOREIGN KEY (region_id) REFERENCES regions(id)
);

-- Festivals Table
CREATE TABLE festivals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name_en VARCHAR(100) NOT NULL,
    name_hi VARCHAR(100),
    description_en TEXT,
    description_hi TEXT,
    month INT NOT NULL,
    region_id INT,
    image_url VARCHAR(255),
    FOREIGN KEY (region_id) REFERENCES regions(id)
);

-- Quiz Questions
CREATE TABLE quiz_questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_en TEXT NOT NULL,
    question_hi TEXT,
    option_a_en VARCHAR(255) NOT NULL,
    option_a_hi VARCHAR(255),
    option_b_en VARCHAR(255) NOT NULL,
    option_b_hi VARCHAR(255),
    option_c_en VARCHAR(255) NOT NULL,
    option_c_hi VARCHAR(255),
    option_d_en VARCHAR(255) NOT NULL,
    option_d_hi VARCHAR(255),
    correct_option CHAR(1) NOT NULL,
    category VARCHAR(50)
);

-- Quiz Scores
CREATE TABLE quiz_scores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert Default Admin
INSERT INTO users (name, email, password, role) VALUES 
('Admin', 'admin@virtualindia.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

-- Insert Regions Data
INSERT INTO regions (name_en, name_hi, description_en, description_hi, states_en, states_hi) VALUES
('North India', 'उत्तर भारत', 'North India is home to the majestic Himalayas, ancient temples, and rich Mughal heritage. This region showcases the blend of Hindu and Islamic architecture, vibrant folk traditions, and diverse cuisines.', 'उत्तर भारत हिमालय, प्राचीन मंदिरों और समृद्ध मुगल विरासत का घर है। यह क्षेत्र हिंदू और इस्लामी वास्तुकला, जीवंत लोक परंपराओं और विविध व्यंजनों का मिश्रण प्रदर्शित करता है।', 'Jammu & Kashmir, Punjab, Haryana, Himachal Pradesh, Uttarakhand, Uttar Pradesh, Delhi, Rajasthan', 'जम्मू-कश्मीर, पंजाब, हरियाणा, हिमाचल प्रदेश, उत्तराखंड, उत्तर प्रदेश, दिल्ली, राजस्थान'),
('South India', 'दक्षिण भारत', 'South India is known for its ancient Dravidian temples, classical dance forms, and rich literary traditions. The region features beautiful backwaters, spice plantations, and unique cuisine.', 'दक्षिण भारत अपने प्राचीन द्रविड़ मंदिरों, शास्त्रीय नृत्य रूपों और समृद्ध साहित्यिक परंपराओं के लिए जाना जाता है। इस क्षेत्र में सुंदर बैकवाटर, मसाले के बागान और अनूठे व्यंजन हैं।', 'Tamil Nadu, Kerala, Karnataka, Andhra Pradesh, Telangana', 'तमिलनाडु, केरल, कर्नाटक, आंध्र प्रदेश, तेलंगाना'),
('East India', 'पूर्व भारत', 'East India is the land of ancient wisdom, featuring the birthplace of Buddhism, tribal cultures, and artistic traditions. The region is known for its silk, tea gardens, and rich festivals.', 'पूर्व भारत प्राचीन ज्ञान की भूमि है, जहां बौद्ध धर्म का जन्मस्थान, आदिवासी संस्कृतियां और कलात्मक परंपराएं हैं। यह क्षेत्र अपने रेशम, चाय बागानों और समृद्ध त्योहारों के लिए जाना जाता है।', 'West Bengal, Bihar, Jharkhand, Odisha, Sikkim, Assam, Meghalaya, Tripura, Mizoram, Manipur, Nagaland, Arunachal Pradesh', 'पश्चिम बंगाल, बिहार, झारखंड, ओडिशा, सिक्किम, असम, मेघालय, त्रिपुरा, मिजोरम, मणिपुर, नागालैंड, अरुणाचल प्रदेश'),
('West India', 'पश्चिम भारत', 'West India showcases vibrant colors, dynamic festivals, and entrepreneurial spirit. From the caves of Ajanta-Ellora to the beaches of Goa, this region offers diverse cultural experiences.', 'पश्चिम भारत जीवंत रंगों, गतिशील त्योहारों और उद्यमशीलता की भावना को प्रदर्शित करता है। अजंता-एलोरा की गुफाओं से लेकर गोवा के समुद्र तटों तक, यह क्षेत्र विविध सांस्कृतिक अनुभव प्रदान करता है।', 'Maharashtra, Gujarat, Goa, Madhya Pradesh, Chhattisgarh', 'महाराष्ट्र, गुजरात, गोवा, मध्य प्रदेश, छत्तीसगढ़');

-- Insert Cultural Items
INSERT INTO cultural_items (region_id, category, name_en, name_hi, description_en, description_hi) VALUES
-- North India
(1, 'dance', 'Kathak', 'कथक', 'One of the eight major forms of Indian classical dance, originating from Uttar Pradesh. Known for intricate footwork and expressive storytelling.', 'भारतीय शास्त्रीय नृत्य के आठ प्रमुख रूपों में से एक, उत्तर प्रदेश से उत्पन्न। जटिल फुटवर्क और अभिव्यक्तिपूर्ण कहानी कहने के लिए जाना जाता है।'),
(1, 'art', 'Madhubani Painting', 'मधुबनी पेंटिंग', 'Traditional folk art from Bihar featuring geometric patterns and mythological themes, painted using natural dyes.', 'बिहार की पारंपरिक लोक कला जिसमें ज्यामितीय पैटर्न और पौराणिक विषय होते हैं, प्राकृतिक रंगों का उपयोग करके चित्रित।'),
(1, 'craft', 'Chikankari', 'चिकनकारी', 'Delicate embroidery work from Lucknow, featuring intricate white threadwork on fine fabric.', 'लखनऊ की नाजुक कढ़ाई का काम, महीन कपड़े पर जटिल सफेद धागे का काम।'),
(1, 'music', 'Bhangra', 'भांगड़ा', 'Energetic folk music and dance form from Punjab, celebrating harvest and joy.', 'पंजाब का ऊर्जावान लोक संगीत और नृत्य रूप, फसल और खुशी का जश्न।'),
-- South India
(2, 'dance', 'Bharatanatyam', 'भरतनाट्यम', 'Ancient classical dance form from Tamil Nadu, known for fixed upper torso, bent legs, and sophisticated vocabulary of sign language.', 'तमिलनाडु का प्राचीन शास्त्रीय नृत्य रूप, स्थिर ऊपरी धड़, मुड़े हुए पैर और सांकेतिक भाषा की परिष्कृत शब्दावली के लिए जाना जाता है।'),
(2, 'art', 'Tanjore Painting', 'तंजावुर पेंटिंग', 'Classical South Indian painting style known for rich colors, surface richness, and compact composition.', 'शास्त्रीय दक्षिण भारतीय पेंटिंग शैली जो समृद्ध रंगों, सतह की समृद्धि और संक्षिप्त रचना के लिए जानी जाती है।'),
(2, 'dance', 'Kathakali', 'कथकली', 'Classical dance-drama from Kerala featuring elaborate costumes, detailed makeup, and stylized gestures.', 'केरल का शास्त्रीय नृत्य-नाटक जिसमें विस्तृत वेशभूषा, विस्तृत मेकअप और शैलीबद्ध हावभाव हैं।'),
(2, 'craft', 'Mysore Silk', 'मैसूर सिल्क', 'Exquisite silk weaving tradition from Karnataka, known for pure gold zari work.', 'कर्नाटक की उत्कृष्ट रेशम बुनाई परंपरा, शुद्ध सोने की जरी के काम के लिए जानी जाती है।'),
-- East India
(3, 'dance', 'Odissi', 'ओडिसी', 'Classical dance form from Odisha, characterized by sculpturesque poses and fluid movements.', 'ओडिशा का शास्त्रीय नृत्य रूप, मूर्तिकला जैसी मुद्राओं और तरल गतिविधियों की विशेषता।'),
(3, 'art', 'Pattachitra', 'पट्टचित्र', 'Traditional cloth-based scroll painting from Odisha with mythological narratives.', 'ओडिशा की पारंपरिक कपड़े-आधारित स्क्रॉल पेंटिंग जिसमें पौराणिक कथाएं हैं।'),
(3, 'craft', 'Banarasi Silk', 'बनारसी सिल्क', 'Finest silk fabric from Varanasi, known for gold and silver brocade with intricate designs.', 'वाराणसी का सबसे महीन रेशमी कपड़ा, जटिल डिजाइनों के साथ सोने और चांदी के ब्रोकेड के लिए जाना जाता है।'),
(3, 'dance', 'Chhau', 'छऊ', 'Martial dance form from Eastern India, combining martial arts, tribal, and folk traditions.', 'पूर्वी भारत का मार्शल नृत्य रूप, मार्शल आर्ट, आदिवासी और लोक परंपराओं का संयोजन।'),
-- West India
(4, 'dance', 'Lavani', 'लावणी', 'Traditional folk dance from Maharashtra known for powerful rhythm and sensuous movements.', 'महाराष्ट्र का पारंपरिक लोक नृत्य जो शक्तिशाली लय और कामुक गतिविधियों के लिए जाना जाता है।'),
(4, 'dance', 'Garba', 'गरबा', 'Vibrant folk dance from Gujarat performed during Navratri with circular movements.', 'गुजरात का जीवंत लोक नृत्य जो नवरात्रि के दौरान गोलाकार गतिविधियों के साथ किया जाता है।'),
(4, 'art', 'Warli Art', 'वारली कला', 'Tribal art form from Maharashtra using basic geometric shapes to depict daily life.', 'महाराष्ट्र की आदिवासी कला जो दैनिक जीवन को चित्रित करने के लिए बुनियादी ज्यामितीय आकृतियों का उपयोग करती है।'),
(4, 'craft', 'Bandhani', 'बांधनी', 'Ancient tie-dye textile art from Gujarat and Rajasthan with intricate patterns.', 'गुजरात और राजस्थान की प्राचीन टाई-डाई कपड़ा कला जिसमें जटिल पैटर्न हैं।');

-- Insert Festivals
INSERT INTO festivals (name_en, name_hi, description_en, description_hi, month, region_id) VALUES
('Diwali', 'दीवाली', 'Festival of Lights celebrating the victory of light over darkness. Homes are decorated with diyas and rangoli.', 'प्रकाश का त्योहार जो अंधकार पर प्रकाश की जीत का जश्न मनाता है। घरों को दीयों और रंगोली से सजाया जाता है।', 10, NULL),
('Holi', 'होली', 'Festival of Colors marking the arrival of spring. People play with colors and celebrate togetherness.', 'रंगों का त्योहार जो वसंत के आगमन का प्रतीक है। लोग रंगों से खेलते हैं और एकजुटता का जश्न मनाते हैं।', 3, 1),
('Pongal', 'पोंगल', 'Harvest festival of Tamil Nadu celebrating the sun god and thanksgiving for good harvest.', 'तमिलनाडु का फसल उत्सव जो सूर्य देव का जश्न मनाता है और अच्छी फसल के लिए धन्यवाद देता है।', 1, 2),
('Onam', 'ओणम', 'Grand harvest festival of Kerala featuring boat races, flower carpets, and traditional feast.', 'केरल का भव्य फसल उत्सव जिसमें नौका दौड़, फूलों की कालीन और पारंपरिक दावत शामिल है।', 8, 2),
('Durga Puja', 'दुर्गा पूजा', 'Grand celebration in West Bengal honoring Goddess Durga with elaborate pandals and cultural programs.', 'पश्चिम बंगाल में देवी दुर्गा के सम्मान में भव्य उत्सव जिसमें विस्तृत पंडाल और सांस्कृतिक कार्यक्रम होते हैं।', 10, 3),
('Bihu', 'बिहू', 'Assamese New Year celebration with traditional dance, music, and feasting.', 'असमिया नव वर्ष उत्सव जिसमें पारंपरिक नृत्य, संगीत और दावत होती है।', 4, 3),
('Ganesh Chaturthi', 'गणेश चतुर्थी', 'Festival celebrating Lord Ganesha with grand processions and immersion ceremonies in Maharashtra.', 'महाराष्ट्र में भव्य जुलूसों और विसर्जन समारोहों के साथ भगवान गणेश का जश्न मनाने वाला त्योहार।', 9, 4),
('Navratri', 'नवरात्रि', 'Nine nights of devotion to Goddess Durga, celebrated with Garba and Dandiya in Gujarat.', 'देवी दुर्गा की भक्ति की नौ रातें, गुजरात में गरबा और डांडिया के साथ मनाई जाती हैं।', 10, 4),
('Baisakhi', 'बैसाखी', 'Harvest festival of Punjab marking the Sikh New Year with fairs and Bhangra performances.', 'पंजाब का फसल उत्सव जो सिख नव वर्ष का प्रतीक है, मेलों और भांगड़ा प्रदर्शनों के साथ।', 4, 1),
('Makar Sankranti', 'मकर संक्रांति', 'Harvest festival celebrating the transition of the Sun, marked by kite flying and traditional sweets.', 'सूर्य के संक्रमण का जश्न मनाने वाला फसल उत्सव, पतंगबाजी और पारंपरिक मिठाइयों द्वारा चिह्नित।', 1, NULL),
('Rath Yatra', 'रथ यात्रा', 'Grand chariot festival in Puri, Odisha where deities are taken on a procession.', 'पुरी, ओडिशा में भव्य रथ उत्सव जहां देवताओं को जुलूस में ले जाया जाता है।', 7, 3),
('Raksha Bandhan', 'रक्षा बंधन', 'Festival celebrating the bond between brothers and sisters with tying of sacred thread.', 'पवित्र धागे बांधने के साथ भाई-बहन के बंधन का जश्न मनाने वाला त्योहार।', 8, 1);

-- Insert Quiz Questions
INSERT INTO quiz_questions (question_en, question_hi, option_a_en, option_a_hi, option_b_en, option_b_hi, option_c_en, option_c_hi, option_d_en, option_d_hi, correct_option, category) VALUES
('Which classical dance form originated from Tamil Nadu?', 'कौन सा शास्त्रीय नृत्य रूप तमिलनाडु से उत्पन्न हुआ?', 'Kathak', 'कथक', 'Bharatanatyam', 'भरतनाट्यम', 'Odissi', 'ओडिसी', 'Kathakali', 'कथकली', 'B', 'dance'),
('Madhubani painting is a traditional art form from which state?', 'मधुबनी पेंटिंग किस राज्य की पारंपरिक कला है?', 'Rajasthan', 'राजस्थान', 'Gujarat', 'गुजरात', 'Bihar', 'बिहार', 'Kerala', 'केरल', 'C', 'art'),
('Which festival is known as the Festival of Lights?', 'कौन सा त्योहार रोशनी का त्योहार कहलाता है?', 'Holi', 'होली', 'Diwali', 'दीवाली', 'Navratri', 'नवरात्रि', 'Pongal', 'पोंगल', 'B', 'festival'),
('Garba dance is traditionally performed during which festival?', 'गरबा नृत्य पारंपरिक रूप से किस त्योहार के दौरान किया जाता है?', 'Diwali', 'दीवाली', 'Holi', 'होली', 'Navratri', 'नवरात्रि', 'Onam', 'ओणम', 'C', 'dance'),
('Chikankari embroidery is famous in which city?', 'चिकनकारी कढ़ाई किस शहर में प्रसिद्ध है?', 'Jaipur', 'जयपुर', 'Lucknow', 'लखनऊ', 'Mysore', 'मैसूर', 'Ahmedabad', 'अहमदाबाद', 'B', 'craft'),
('Which state celebrates Onam as its major festival?', 'कौन सा राज्य ओणम को अपने प्रमुख त्योहार के रूप में मनाता है?', 'Tamil Nadu', 'तमिलनाडु', 'Karnataka', 'कर्नाटक', 'Kerala', 'केरल', 'Andhra Pradesh', 'आंध्र प्रदेश', 'C', 'festival'),
('Warli art is a tribal art form from which state?', 'वारली कला किस राज्य की आदिवासी कला है?', 'Maharashtra', 'महाराष्ट्र', 'Madhya Pradesh', 'मध्य प्रदेश', 'Odisha', 'ओडिशा', 'Jharkhand', 'झारखंड', 'A', 'art'),
('Which dance form is known for its elaborate makeup and costumes from Kerala?', 'केरल की कौन सी नृत्य शैली अपने विस्तृत मेकअप और वेशभूषा के लिए जानी जाती है?', 'Bharatanatyam', 'भरतनाट्यम', 'Mohiniyattam', 'मोहिनीअट्टम', 'Kathakali', 'कथकली', 'Kuchipudi', 'कुचिपुड़ी', 'C', 'dance'),
('Banarasi silk is famous for which type of work?', 'बनारसी सिल्क किस प्रकार के काम के लिए प्रसिद्ध है?', 'Block printing', 'ब्लॉक प्रिंटिंग', 'Zari work', 'जरी का काम', 'Batik', 'बाटिक', 'Phulkari', 'फुलकारी', 'B', 'craft'),
('Durga Puja is most grandly celebrated in which state?', 'दुर्गा पूजा किस राज्य में सबसे भव्य रूप से मनाई जाती है?', 'Bihar', 'बिहार', 'West Bengal', 'पश्चिम बंगाल', 'Assam', 'असम', 'Odisha', 'ओडिशा', 'B', 'festival');
