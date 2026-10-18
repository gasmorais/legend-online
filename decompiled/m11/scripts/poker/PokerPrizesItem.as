package poker
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.pet.CardMsg;
   import com.road.yishi.proto.pet.TablePotDivisionMsg;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import mvc.module.poker.PokerPlayerInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   
   public class PokerPrizesItem extends Component
   {
      
      private var _itemBg:DisplayObject;
      
      private var _lightBg:DisplayObject;
      
      private var _nameTxt:FilterFrameText;
      
      private var _cashTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _handTypeTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      public function PokerPrizesItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("poker.itemBgGray");
         _lightBg = ComponentFactory.Instance.creatComponentByStylename("poker.itemBgLight");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesNameTxt");
         _cashTxt = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesCashTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesScoreTxt");
         _handTypeTxt = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesHandTypeTxt");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("poker.PokerPrizesItem.cardBox");
         addChild(_itemBg);
         addChild(_lightBg);
         addChild(_nameTxt);
         addChild(_cashTxt);
         addChild(_scoreTxt);
         addChild(_handTypeTxt);
         addChild(_hbox);
         _lightBg.visible = false;
      }
      
      public function set data(param1:TablePotDivisionMsg) : void
      {
         var _loc7_:PokerCardView = null;
         var _loc3_:CardMsg = null;
         var _loc4_:int = 0;
         _nameTxt.text = param1.player.userName;
         _cashTxt.text = cashStr(param1);
         _scoreTxt.text = param1.score + "";
         var _loc2_:Array = param1.rankingArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as CardMsg;
            _loc7_ = new PokerCardView(_loc3_.suit,_loc3_.rank);
            _loc7_.scaleX = 0.4;
            _loc7_.scaleY = 0.4;
            _hbox.addChild(_loc7_);
            _loc4_++;
         }
         if(param1.handType >= 0)
         {
            _handTypeTxt.text = LanguageMgr.GetTranslation("poker.PokerPlayerView.handType" + param1.handType);
         }
         var _loc8_:PokerPlayerInfo = PokerManager.instance.getPokerPlayerById(param1.player.userId,param1.player.serverName);
         if(!_loc8_ || _loc8_ && _loc8_.action == 5)
         {
            _handTypeTxt.text = LanguageMgr.GetTranslation("poker.PokerPlayerView.handType100");
         }
         if(param1.handType == 0 && _loc8_ && _loc8_.cardArr.length == 0)
         {
            _handTypeTxt.text = LanguageMgr.GetTranslation("poker.PokerPlayerView.handType100");
         }
         if(_loc2_.length)
         {
            _handTypeTxt.x = 450;
         }
         var _loc6_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         var _loc5_:String = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _lightBg.visible = param1.player.userId == _loc6_ && param1.player.serverName == _loc5_;
      }
      
      private function cashStr(param1:TablePotDivisionMsg) : String
      {
         var _loc2_:String = "";
         if(param1.potShare > 0)
         {
            _loc2_ += String(param1.potShare);
         }
         if(param1.potShare > 0 && param1.invalidShare > 0)
         {
            _loc2_ += "+";
         }
         if(param1.invalidShare > 0)
         {
            _loc2_ += param1.invalidShare + LanguageMgr.GetTranslation("poker.PokerPrizesItem.invalid");
         }
         if(param1.potShare == 0 && param1.invalidShare == 0)
         {
            _loc2_ += "0";
         }
         return _loc2_;
      }
      
      public function get palyerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_lightBg);
         _lightBg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_cashTxt);
         _cashTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_handTypeTxt);
         _handTypeTxt = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         super.dispose();
      }
   }
}

