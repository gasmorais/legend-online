package colosseum.view
{
   import avatar.view.ShowAvatar;
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ColosseumControler;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ColosseumPlayerItem extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _figure:ShowAvatar;
      
      private var _effect:Bitmap;
      
      private var _back2:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _rankValue:FilterFrameText;
      
      private var _startBtn:BaseButton;
      
      private var _thane:ThaneInfo;
      
      private var _mask:Shape;
      
      public function ColosseumPlayerItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.colosseum.ItemBack1");
         _effect = ComponentFactory.Instance.creatBitmap("asset.colosseum.ItemEffect");
         _back2 = ComponentFactory.Instance.creatBitmap("asset.colosseum.ItemRankBack");
         _figure = new ShowAvatar();
         _figure.x = 0;
         _figure.y = 13;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _level = ComponentFactory.Instance.creatComponentByStylename("colosseum.ItemLevel");
         _name = ComponentFactory.Instance.creatComponentByStylename("colosseum.ItemName");
         _rankValue = ComponentFactory.Instance.creatComponentByStylename("colosseum.ItemRankValue");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("colosseum.StartBtn");
         _effect.visible = false;
         addChild(_back);
         addChild(_figure);
         _figure.scaleX = _figure.scaleY = 0.85;
         addChild(_back2);
         addChild(_effect);
         addChild(_level);
         addChild(_name);
         addChild(_rankValue);
         addChild(_startBtn);
         _startBtn.visible = false;
         _figure.mask = _mask = createMask();
         addChild(_mask);
      }
      
      private function createMask() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(6,2,224,235);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         _startBtn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         _startBtn.removeEventListener("click",__clickHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _effect.visible = true;
         _startBtn.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _effect.visible = false;
         _startBtn.visible = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         if(_thane)
         {
            _loc2_ = "";
            if(!BuildingManager.instance.model.checkHasIdleColosseumOrder())
            {
               _loc2_ = LanguageMgr.GetTranslation("colosseum.view.ColosseumListView.command02");
               MessageTipManager.instance().show(_loc2_);
               control.frame["showEffect"]();
               return;
            }
            _loc4_ = SceneManager.instance.currentType;
            if(_loc4_ == "PVP_ROOM_SCENE" || _loc4_ == "PVP_ROOM_SCENE" || _loc4_ == "WARLORDS_ROOM")
            {
               _loc2_ = LanguageMgr.GetTranslation("colosseum.view.ColosseumListView.command03");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(_loc4_ == "CAMPAIGN_MAP_SCENE")
            {
               MessageTipManager.instance().show(WorldBossHelper.getCampaignTips());
               return;
            }
            if(control.model.remainFreeCount <= 0)
            {
               if(control.model.remainBuyCount > 0)
               {
                  _loc3_ = int(control.model.buyCountNeedPay);
                  _loc2_ = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.buyCountTip",_loc3_);
                  SimpleAlertHelper.instance.data = [sendChallenge,_loc3_];
                  SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true,false,false,2,"USEBINDPOINT_ALERT");
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("colosseum.view.ColosseumListView.command01");
                  MessageTipManager.instance().show(_loc2_);
               }
               return;
            }
            sendChallenge(true,true);
         }
      }
      
      private function sendChallenge(param1:Boolean, param2:Boolean, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         if(param1 && _thane)
         {
            _loc4_ = int(param2 ? playerInfo.point + playerInfo.giftToken : playerInfo.point);
            if(_loc4_ < param3)
            {
               RechargeAlertMannager.show();
               return;
            }
            BattleManager.preScene = SwitchPageHelp.returnScene;
            control.sendChallengeById(_thane.userId,param2 ? 0 : 1);
         }
      }
      
      private function get control() : ColosseumControler
      {
         return FrameControllerManager.instance.colosseumControler;
      }
      
      public function set thane(param1:ThaneInfo) : void
      {
         _thane = param1;
         refreshView();
      }
      
      public function get backBitmap() : Bitmap
      {
         return _back;
      }
      
      private function refreshView() : void
      {
         if(_thane)
         {
            _level.text = LanguageMgr.GetTranslation("public.level2",_thane.grades);
            _name.text = _thane.nickName;
            if(_thane.challengeRank == 0)
            {
               _rankValue.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
            }
            else
            {
               _rankValue.text = LanguageMgr.GetTranslation("public.rank",_thane.challengeRank);
            }
            _figure.data = _thane;
         }
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rankValue);
         _rankValue = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_level);
         _level = null;
         ObjectUtils.disposeAllChildren(this);
         _thane = null;
      }
   }
}

