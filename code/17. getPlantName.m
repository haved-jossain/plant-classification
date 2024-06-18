function [s_name l_name] = getPlantName( plantIndex )
% GETPLANTNAME gets the local and scientific name of a plant based on the
% plant index.
%
% PARAMETERS:
%       plantIndex = predetermined index associated with the plant species
%
% OUTPUT:
%       s_name = scientific name of the plant
%       l_name = local name of the plant
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Initialize plant names
s_name = 'Unknown plant';
l_name = 'Unknown plant';

% Get the plant names based on the plant index.
switch plantIndex
    case 101
        s_name = ' Oxalis Arborea';
        l_name = ' Wood Sorrel';                  
    case 102
        s_name = ' Sesbania Drummondii';
        l_name = ' Rattlebush';                  
    case 103
        s_name = ' Senna Pendula';
        l_name = ' Cassia';    
    case 104
        s_name = ' Cosmos Sulphureus';
        l_name = ' Orange Cosmos';
    case 105
        s_name = ' Moringa Oleifera';
        l_name = ' Sajna';
    case 1
        s_name = ' Phyllostachys Edulis';
        l_name = ' Pubescent Bamboo';
    case 2
        s_name = ' Aesculus Chinensis';
        l_name = ' Chinese Horse Chestnut';
    case 3
        s_name = ' Cercis Chinensis';
        l_name = ' Chinese Redbud';
    case 4
        s_name = ' Indigofera Tinctoria';
        l_name = ' True Indigo';
    case 5
        s_name = ' Acer Palmatum';
        l_name = ' Japanese Maple';
    case 6
        s_name = ' Phoebe Nanmu';
        l_name = ' Nanmu';
    case 7
        s_name = ' Koelreuteria Paniculata';
        l_name = ' Castor Aralia';
    case 8
        s_name = ' Kalopanax Septemlobus';
        l_name = ' Goldenrain Tree';
    case 9
        s_name = ' Cinnamomum Japonicum';
        l_name = ' Chinese Cinnamon';
    case 10
        s_name = ' Berberis Anhweiensis';
        l_name = ' Anhui Barberry';
    case 11
        s_name = ' Ilex Macrocarpa';
        l_name = ' Big-Fruited Holly';
    case 12
        s_name = ' Pittosporum Tobira';
        l_name = ' Japanese Cheesewood';
    case 13
        s_name = ' Chimonanthus Praecox.';
        l_name = ' Wintersweet';
    case 14
        s_name = ' Cinnamomum Camphora';
        l_name = ' Camphortree';
    case 15
        s_name = ' Viburnum Awabuki';
        l_name = ' Japan Arrowwood';
    case 16
        s_name = ' Osmanthus Fragrans';
        l_name = ' Sweet Osmanthus';
    case 17
        s_name = ' Cedrus Deodara';
        l_name = ' Deodar';
    case 18
        s_name = ' Lagerstroemia Indica';
        l_name = ' Crape Myrtle';
    case 19
        s_name = ' Nerium Oleander';
        l_name = ' Oleander';
    case 20
        s_name = ' Podocarpus Macrophyllus';
        l_name = ' Yew Plum Pine';
    case 21
        s_name = ' Prunus Serrulata';
        l_name = ' Japanese Cherry ';
    case 22
        s_name = ' Ligustrum Lucidum';
        l_name = ' Glossy Privet';
    case 23
        s_name = ' Tonna Sinensis';
        l_name = ' Chinese Toon';
    case 24
        s_name = ' Prunus Persica';
        l_name = ' Peach';
    case 25
        s_name = ' Manglietia Fordiana';
        l_name = ' Ford Woodlotus';
    case 26
        s_name = ' Acer Buergerianum';
        l_name = ' Trident Maple';
    case 27
        s_name = ' Mahonia Bealei';
        l_name = ' Beale`s Barberry';
    case 28
        s_name = ' Magnolia Grandiflora';
        l_name = ' Southern Magnolia';
    case 29
        s_name = ' Populus Canadensis';
        l_name = ' Canadian Poplar';
    case 30
        s_name = ' Citrus Reticulata';
        l_name = ' Tangerine';           
end
