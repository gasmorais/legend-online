package mvc.module.currency
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class PlayerCurrencyInfo extends EventDispatcher
   {
      
      private var _petCrystal:CurrencyInfo;
      
      private var _petSpirit:CurrencyInfo;
      
      private var _petBreath:CurrencyInfo;
      
      private var _petFireCream:CurrencyInfo;
      
      private var _petWaterCream:CurrencyInfo;
      
      private var _petElectricCream:CurrencyInfo;
      
      private var _petWindCream:CurrencyInfo;
      
      private var _petExchangeCoin:CurrencyInfo;
      
      private var _guildSkill:CurrencyInfo;
      
      private var _godWiner:CurrencyInfo;
      
      private var _chaos:CurrencyInfo;
      
      private var _arenaMedal:CurrencyInfo;
      
      private var _starScore:CurrencyInfo;
      
      private var _lightScore:CurrencyInfo;
      
      private var _purpleCrystal:CurrencyInfo;
      
      private var _shopScore:CurrencyInfo;
      
      private var _leagueScore:CurrencyInfo;
      
      private var _godsExchenge:CurrencyInfo;
      
      private var _mazeGold:CurrencyInfo;
      
      private var _eternalCrystal:CurrencyInfo;
      
      private var _remotePetFlag:CurrencyInfo;
      
      private var _magicDust:CurrencyInfo;
      
      private var _mountCoin:CurrencyInfo;
      
      private var _outyardCoin:CurrencyInfo;
      
      private var _bingoCoin:CurrencyInfo;
      
      private var _gameBoxCoin:CurrencyInfo;
      
      private var _aresHeart:CurrencyInfo;
      
      private var _athenaTear:CurrencyInfo;
      
      private var _yarramanCoin:CurrencyInfo;
      
      private var _newMagicDust:CurrencyInfo;
      
      private var _gloryCoin:CurrencyInfo;
      
      private var _yellowCoin:CurrencyInfo;
      
      private var _exploreMedal:CurrencyInfo;
      
      private var _assaultwarMedal:CurrencyInfo;
      
      private var _typeToCatToyCurrencyInfoDic:Dictionary = new Dictionary();
      
      private var _magicPubCurrencyInfoDic:Dictionary = new Dictionary();
      
      private var _godsMarking:CurrencyInfo;
      
      private var _copyConsortia:CurrencyInfo;
      
      private var _crossGuildCoin:CurrencyInfo;
      
      private var _apexCoin:CurrencyInfo;
      
      private var _antaeusCoin:CurrencyInfo;
      
      private var _airGardenPropCoin:CurrencyInfo;
      
      private var _airGardenBedCoin:CurrencyInfo;
      
      private var _eastEggCoin:CurrencyInfo;
      
      private var _eastTickesCoin:CurrencyInfo;
      
      private var _theseuscollectionBox:CurrencyInfo;
      
      private var _theseusshuijing:CurrencyInfo;
      
      private var _flameTempleCoin:CurrencyInfo;
      
      private var _duskAreaCoin:CurrencyInfo;
      
      private var _demonroadCoin:CurrencyInfo;
      
      private var _darkmazeSoulCoin:CurrencyInfo;
      
      private var _consortiaNewBossCoin:CurrencyInfo;
      
      private var _poseidonCoin:CurrencyInfo;
      
      private var _thesepvpMedal:CurrencyInfo;
      
      private var _thesepvpHoner:CurrencyInfo;
      
      private var _thesedoublepvpHoner:CurrencyInfo;
      
      private var _secretwarShopCoin:CurrencyInfo;
      
      private var _minosCoin:CurrencyInfo;
      
      private var _gemDust:CurrencyInfo;
      
      private var _yearBoxKey:CurrencyInfo;
      
      private var _yearEggTicket:CurrencyInfo;
      
      private var _yearGold:CurrencyInfo;
      
      private var _chessPvpCoin:CurrencyInfo;
      
      private var _childNsWarCoin:CurrencyInfo;
      
      public function PlayerCurrencyInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get magicDust() : CurrencyInfo
      {
         return _magicDust;
      }
      
      public function set magicDust(param1:CurrencyInfo) : void
      {
         _magicDust = param1;
      }
      
      public function get newMagicDust() : CurrencyInfo
      {
         return _newMagicDust;
      }
      
      public function set newMagicDust(param1:CurrencyInfo) : void
      {
         _newMagicDust = param1;
         _newMagicDust.sort = 4;
      }
      
      public function get yarramanCoin() : CurrencyInfo
      {
         return _yarramanCoin;
      }
      
      public function set yarramanCoin(param1:CurrencyInfo) : void
      {
         _yarramanCoin = param1;
         _yarramanCoin.sort = 120;
      }
      
      public function get mazeGold() : CurrencyInfo
      {
         return _mazeGold;
      }
      
      public function set mazeGold(param1:CurrencyInfo) : void
      {
         _mazeGold = param1;
         _mazeGold.sort = 170;
      }
      
      public function get gemDust() : CurrencyInfo
      {
         return _gemDust;
      }
      
      public function set gemDust(param1:CurrencyInfo) : void
      {
         _gemDust = param1;
      }
      
      public function get godsExchenge() : CurrencyInfo
      {
         return _godsExchenge;
      }
      
      public function set godsExchenge(param1:CurrencyInfo) : void
      {
         _godsExchenge = param1;
      }
      
      public function get leagueScore() : CurrencyInfo
      {
         return _leagueScore;
      }
      
      public function set leagueScore(param1:CurrencyInfo) : void
      {
         _leagueScore = param1;
      }
      
      public function get shopScore() : CurrencyInfo
      {
         return _shopScore;
      }
      
      public function set shopScore(param1:CurrencyInfo) : void
      {
         _shopScore = param1;
      }
      
      public function get purpleCrystal() : CurrencyInfo
      {
         return _purpleCrystal;
      }
      
      public function set purpleCrystal(param1:CurrencyInfo) : void
      {
         _purpleCrystal = param1;
      }
      
      public function get lightScore() : CurrencyInfo
      {
         return _lightScore;
      }
      
      public function set lightScore(param1:CurrencyInfo) : void
      {
         _lightScore = param1;
      }
      
      public function get starScore() : CurrencyInfo
      {
         return _starScore;
      }
      
      public function set starScore(param1:CurrencyInfo) : void
      {
         _starScore = param1;
      }
      
      public function get arenaMedal() : CurrencyInfo
      {
         return _arenaMedal;
      }
      
      public function set arenaMedal(param1:CurrencyInfo) : void
      {
         param1.sort = 60;
         _arenaMedal = param1;
      }
      
      public function get godWiner() : CurrencyInfo
      {
         return _godWiner;
      }
      
      public function set godWiner(param1:CurrencyInfo) : void
      {
         param1.sort = 150;
         _godWiner = param1;
      }
      
      public function get chaos() : CurrencyInfo
      {
         return _chaos;
      }
      
      public function set chaos(param1:CurrencyInfo) : void
      {
         param1.sort = 160;
         _chaos = param1;
      }
      
      public function get eternalCrystal() : CurrencyInfo
      {
         return _eternalCrystal;
      }
      
      public function set eternalCrystal(param1:CurrencyInfo) : void
      {
         param1.sort = 180;
         _eternalCrystal = param1;
      }
      
      public function get guildSkill() : CurrencyInfo
      {
         return _guildSkill;
      }
      
      public function set guildSkill(param1:CurrencyInfo) : void
      {
         param1.sort = 50;
         _guildSkill = param1;
      }
      
      public function get yellowCoin() : CurrencyInfo
      {
         return _yellowCoin;
      }
      
      public function set yellowCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 230;
         _yellowCoin = param1;
      }
      
      public function get petWindCream() : CurrencyInfo
      {
         return _petWindCream;
      }
      
      public function set petWindCream(param1:CurrencyInfo) : void
      {
         param1.sort = 70;
         _petWindCream = param1;
      }
      
      public function get petElectricCream() : CurrencyInfo
      {
         return _petElectricCream;
      }
      
      public function set petElectricCream(param1:CurrencyInfo) : void
      {
         param1.sort = 100;
         _petElectricCream = param1;
      }
      
      public function get petWaterCream() : CurrencyInfo
      {
         return _petWaterCream;
      }
      
      public function set petWaterCream(param1:CurrencyInfo) : void
      {
         param1.sort = 90;
         _petWaterCream = param1;
      }
      
      public function get petFireCream() : CurrencyInfo
      {
         return _petFireCream;
      }
      
      public function set petFireCream(param1:CurrencyInfo) : void
      {
         param1.sort = 80;
         _petFireCream = param1;
      }
      
      public function get petCrystal() : CurrencyInfo
      {
         return _petCrystal;
      }
      
      public function get petSpirit() : CurrencyInfo
      {
         return _petSpirit;
      }
      
      public function get petBreath() : CurrencyInfo
      {
         return _petBreath;
      }
      
      public function setCatToyCurrencyInfo(param1:CurrencyInfo) : void
      {
         _typeToCatToyCurrencyInfoDic[param1.masterType] = param1;
      }
      
      public function getCatToyCurrencyInfoByType(param1:int) : CurrencyInfo
      {
         return _typeToCatToyCurrencyInfoDic[param1];
      }
      
      public function setMagicPubCurrencyInfo(param1:CurrencyInfo) : void
      {
         _magicPubCurrencyInfoDic[param1.masterType] = param1;
      }
      
      public function getMagicPubCurrencyInfoByType(param1:int) : CurrencyInfo
      {
         return _magicPubCurrencyInfoDic[param1];
      }
      
      public function set petCrystal(param1:CurrencyInfo) : void
      {
         param1.sort = 110;
         _petCrystal = param1;
      }
      
      public function set petSpirit(param1:CurrencyInfo) : void
      {
         param1.sort = 66;
         _petSpirit = param1;
      }
      
      public function set petBreath(param1:CurrencyInfo) : void
      {
         param1.sort = 67;
         _petBreath = param1;
      }
      
      public function get remotePetFlag() : CurrencyInfo
      {
         return _remotePetFlag;
      }
      
      public function set remotePetFlag(param1:CurrencyInfo) : void
      {
         _remotePetFlag = param1;
      }
      
      public function get mountCoin() : CurrencyInfo
      {
         return _mountCoin;
      }
      
      public function set mountCoin(param1:CurrencyInfo) : void
      {
         _mountCoin = param1;
         _mountCoin.sort = 2;
      }
      
      public function get outyardCoin() : CurrencyInfo
      {
         return _outyardCoin;
      }
      
      public function set outyardCoin(param1:CurrencyInfo) : void
      {
         _outyardCoin = param1;
         _outyardCoin.sort = 6;
      }
      
      public function get bingoCoin() : CurrencyInfo
      {
         return _bingoCoin;
      }
      
      public function set bingoCoin(param1:CurrencyInfo) : void
      {
         _bingoCoin = param1;
         _bingoCoin.sort = 8;
      }
      
      public function get gameBoxCoin() : CurrencyInfo
      {
         return _gameBoxCoin;
      }
      
      public function set gameBoxCoin(param1:CurrencyInfo) : void
      {
         _gameBoxCoin = param1;
      }
      
      public function get aresHeart() : CurrencyInfo
      {
         return _aresHeart;
      }
      
      public function set aresHeart(param1:CurrencyInfo) : void
      {
         param1.sort = 190;
         _aresHeart = param1;
      }
      
      public function get athenaTear() : CurrencyInfo
      {
         return _athenaTear;
      }
      
      public function set athenaTear(param1:CurrencyInfo) : void
      {
         param1.sort = 195;
         _athenaTear = param1;
      }
      
      public function get gloryCoin() : CurrencyInfo
      {
         return _gloryCoin;
      }
      
      public function set gloryCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 22 * 10;
         _gloryCoin = param1;
      }
      
      public function get exploreMedal() : CurrencyInfo
      {
         return _exploreMedal;
      }
      
      public function set exploreMedal(param1:CurrencyInfo) : void
      {
         param1.sort = 24 * 10;
         _exploreMedal = param1;
      }
      
      public function get godsMarking() : CurrencyInfo
      {
         return _godsMarking;
      }
      
      public function set godsMarking(param1:CurrencyInfo) : void
      {
         param1.sort = 46 * 10;
         _godsMarking = param1;
      }
      
      public function get assaultwarMedal() : CurrencyInfo
      {
         return _assaultwarMedal;
      }
      
      public function set assaultwarMedal(param1:CurrencyInfo) : void
      {
         param1.sort = 28 * 10;
         _assaultwarMedal = param1;
      }
      
      public function get petExchangeCoin() : CurrencyInfo
      {
         return _petExchangeCoin;
      }
      
      public function set petExchangeCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 65;
         _petExchangeCoin = param1;
      }
      
      public function get copyConsortia() : CurrencyInfo
      {
         return _copyConsortia;
      }
      
      public function set copyConsortia(param1:CurrencyInfo) : void
      {
         param1.sort = 300;
         _copyConsortia = param1;
      }
      
      public function get crossGuildCoin() : CurrencyInfo
      {
         return _crossGuildCoin;
      }
      
      public function set crossGuildCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 31 * 10;
         _crossGuildCoin = param1;
      }
      
      public function get apexCoin() : CurrencyInfo
      {
         return _apexCoin;
      }
      
      public function set apexCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 30 * 10;
         _apexCoin = param1;
      }
      
      public function get antaeusCoin() : CurrencyInfo
      {
         return _antaeusCoin;
      }
      
      public function set antaeusCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 32 * 10;
         _antaeusCoin = param1;
      }
      
      public function get airGardenPropCoin() : CurrencyInfo
      {
         return _airGardenPropCoin;
      }
      
      public function set airGardenPropCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 33 * 10;
         _airGardenPropCoin = param1;
      }
      
      public function get airGardenBedCoin() : CurrencyInfo
      {
         return _airGardenBedCoin;
      }
      
      public function set airGardenBedCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 34 * 10;
         _airGardenBedCoin = param1;
      }
      
      public function get eastEggCoin() : CurrencyInfo
      {
         return _eastEggCoin;
      }
      
      public function set eastEggCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 35 * 10;
         _eastEggCoin = param1;
      }
      
      public function get eastTickesCoin() : CurrencyInfo
      {
         return _eastTickesCoin;
      }
      
      public function set eastTickesCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 36 * 10;
         _eastTickesCoin = param1;
      }
      
      public function get theseuscollectionBox() : CurrencyInfo
      {
         return _theseuscollectionBox;
      }
      
      public function set theseuscollectionBox(param1:CurrencyInfo) : void
      {
         param1.sort = 70 * 10;
         _theseuscollectionBox = param1;
      }
      
      public function get theseusshuijing() : CurrencyInfo
      {
         return _theseusshuijing;
      }
      
      public function set theseusshuijing(param1:CurrencyInfo) : void
      {
         param1.sort = 70 * 10;
         _theseusshuijing = param1;
      }
      
      public function get duskAreaCoin() : CurrencyInfo
      {
         return _duskAreaCoin;
      }
      
      public function set duskAreaCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 62;
         _duskAreaCoin = param1;
      }
      
      public function set demonroadCoin(param1:CurrencyInfo) : void
      {
         _demonroadCoin = param1;
      }
      
      public function get demonroadCoin() : CurrencyInfo
      {
         return _demonroadCoin;
      }
      
      public function get flameTempleCoin() : CurrencyInfo
      {
         return _flameTempleCoin;
      }
      
      public function set flameTempleCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 61;
         _flameTempleCoin = param1;
      }
      
      public function get darkmazeSoulCoin() : CurrencyInfo
      {
         return _darkmazeSoulCoin;
      }
      
      public function set darkmazeSoulCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 39 * 10;
         _darkmazeSoulCoin = param1;
      }
      
      public function get consortiaNewBossCoin() : CurrencyInfo
      {
         return _consortiaNewBossCoin;
      }
      
      public function set consortiaNewBossCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 57 * 10;
         _consortiaNewBossCoin = param1;
      }
      
      public function get poseidonCoin() : CurrencyInfo
      {
         return _poseidonCoin;
      }
      
      public function set poseidonCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 58 * 10;
         _poseidonCoin = param1;
      }
      
      public function get thesepvpMedal() : CurrencyInfo
      {
         return _thesepvpMedal;
      }
      
      public function set thesepvpMedal(param1:CurrencyInfo) : void
      {
         param1.sort = 59 * 10;
         _thesepvpMedal = param1;
      }
      
      public function get thesepvpHoner() : CurrencyInfo
      {
         return _thesepvpHoner;
      }
      
      public function set thesepvpHoner(param1:CurrencyInfo) : void
      {
         param1.sort = 60 * 10;
         _thesepvpHoner = param1;
      }
      
      public function get theseDoublepvpHoner() : CurrencyInfo
      {
         return _thesedoublepvpHoner;
      }
      
      public function set theseDoublepvpHoner(param1:CurrencyInfo) : void
      {
         param1.sort = 69 * 10;
         _thesedoublepvpHoner = param1;
      }
      
      public function get secretwarShopCoin() : CurrencyInfo
      {
         return _secretwarShopCoin;
      }
      
      public function set secretwarShopCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 61 * 10;
         _secretwarShopCoin = param1;
      }
      
      public function get yearBoxKey() : CurrencyInfo
      {
         return _yearBoxKey;
      }
      
      public function set yearBoxKey(param1:CurrencyInfo) : void
      {
         param1.sort = 62 * 10;
         _yearBoxKey = param1;
      }
      
      public function get yearEggTicket() : CurrencyInfo
      {
         return _yearEggTicket;
      }
      
      public function set yearEggTicket(param1:CurrencyInfo) : void
      {
         param1.sort = 63 * 10;
         _yearEggTicket = param1;
      }
      
      public function get yearGold() : CurrencyInfo
      {
         return _yearGold;
      }
      
      public function set yearGold(param1:CurrencyInfo) : void
      {
         param1.sort = 64 * 10;
         _yearGold = param1;
      }
      
      public function get minosCoin() : CurrencyInfo
      {
         return _minosCoin;
      }
      
      public function set minosCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 65 * 10;
         _minosCoin = param1;
      }
      
      public function get chessPvpCoin() : CurrencyInfo
      {
         return _chessPvpCoin;
      }
      
      public function set chessPvpCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 66 * 10;
         _chessPvpCoin = param1;
      }
      
      public function set childNsWarCoin(param1:CurrencyInfo) : void
      {
         param1.sort = 67 * 10;
         _childNsWarCoin = param1;
      }
      
      public function get childNsWarCoin() : CurrencyInfo
      {
         return _childNsWarCoin;
      }
   }
}

