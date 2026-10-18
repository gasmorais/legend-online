package colosseum.view
{
   import avatar.view.ShowAvatar;
   import battle.BattleManager;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.scene.SceneManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChallengeMiddleItem extends Sprite implements Disposeable
   {
      
      private var _thaneName:FilterFrameText;
      
      private var _avatar:ShowAvatar;
      
      private var _cushion:Bitmap;
      
      private var _fightImg:Bitmap;
      
      private var _fightSprite:Sprite;
      
      private var _rankSprite:Sprite;
      
      private var _rankBmd:BitmapData;
      
      private var _fightBmp:BitmapData;
      
      private var _avatarSprite:Component;
      
      private var _effect:MovieClip;
      
      private var _notInRank:Bitmap;
      
      private var _hitSprite:Sprite;
      
      private var _data:ThaneInfo;
      
      public function ChallengeMiddleItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _thaneName = ComponentFactory.Instance.creatComponentByStylename("colosseum.challengeMiddleView.thanename");
         _avatar = ComponentFactory.Instance.creatCustomObject("colosseum.ShowAvatar",[false,__onCompleteHandler,true]);
         _cushion = ComponentFactory.Instance.creatBitmap("asset.challenge.middleView.cushion");
         _fightImg = ComponentFactory.Instance.creatBitmap("asset.challenge.middleView.Fightimg");
         _fightBmp = ComponentFactory.Instance.creatBitmapData("asset.challenge.numTxt");
         _effect = ComponentFactory.Instance.creatCustomObject("asset.challenge.selected");
         _rankBmd = ComponentFactory.Instance.creatBitmapData("asset.challenge.ranknumTxt");
         _notInRank = ComponentFactory.Instance.creatBitmap("asset.challenge.notInRank");
         _avatarSprite = new Component();
         _fightSprite = new Sprite();
         _rankSprite = new Sprite();
         _hitSprite = new Sprite();
         _fightSprite.y = 60;
         _rankSprite.y = 21;
         addChild(_cushion);
         addChild(_effect);
         _effect.mouseChildren = false;
         _effect.mouseEnabled = false;
         addChild(_avatarSprite);
         addChild(_fightImg);
         addChild(_fightSprite);
         addChild(_rankSprite);
         addChild(_thaneName);
         addChild(_hitSprite);
         addChild(_notInRank);
         _notInRank.visible = false;
         _avatarSprite.buttonMode = true;
         _hitSprite.buttonMode = true;
      }
      
      private function initEvent() : void
      {
         _avatarSprite.addEventListener("mouseOver",__overHandler);
         _avatarSprite.addEventListener("mouseOut",__outHandler);
         _avatarSprite.addEventListener("click",__avatarClickHandler);
         _hitSprite.addEventListener("click",__thaneNameHandler);
      }
      
      private function removeEvent() : void
      {
         _avatarSprite.removeEventListener("mouseOver",__overHandler);
         _avatarSprite.removeEventListener("mouseOut",__outHandler);
         _avatarSprite.removeEventListener("click",__avatarClickHandler);
         _hitSprite.removeEventListener("click",__thaneNameHandler);
      }
      
      private function __avatarClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         if(_data)
         {
            _loc2_ = "";
            if(!BuildingManager.instance.model.checkHasIdleColosseumOrder())
            {
               _loc2_ = LanguageMgr.GetTranslation("colosseum.view.ColosseumListView.command02");
               MessageTipManager.instance().show(_loc2_);
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
            if(model.remainFreeCount <= 0)
            {
               if(model.remainBuyCount > 0)
               {
                  _loc3_ = int(model.buyCountNeedPay);
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
         if(param1 && _data)
         {
            _loc4_ = int(param2 ? playerInfo.point + playerInfo.giftToken : playerInfo.point);
            if(_loc4_ < param3)
            {
               RechargeAlertMannager.show();
               return;
            }
            BattleManager.preScene = SwitchPageHelp.returnScene;
            ChallengeManager.instance.sendChallengeById(_data.userId,param2 ? 0 : 1);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_avatar)
         {
            TweenMax.to(_avatar,0.5,{
               "glowFilter":{
                  "color":16777215,
                  "alpha":1,
                  "blurX":4,
                  "blurY":4,
                  "strength":10,
                  "quality":1
               },
               "repeat":-1,
               "yoyo":true
            });
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_avatar)
         {
            TweenMax.killTweensOf(_avatar);
            _avatar.filters = [];
         }
      }
      
      private function get model() : ColosseumModel
      {
         return ChallengeManager.instance.model;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __thaneNameHandler(param1:MouseEvent) : void
      {
         if(ArmyManager.instance.thane.grades < 16)
         {
            return;
         }
         PlayerInfoManager.instance.show(_data);
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         _avatar.data = _data;
         setFightNumberView(_data.fightingCapacity);
         if(_data.challengeRank > 0)
         {
            _notInRank.visible = false;
            setRankNumberView(_data.challengeRank);
         }
         else
         {
            _notInRank.visible = true;
            _notInRank.x = -27;
         }
         _effect.gotoAndPlay(1);
         _effect.visible = false;
         _thaneName.htmlText = _data.nickName;
         if(_data.userId == thane.userId)
         {
            _effect.visible = true;
            _avatarSprite.mouseEnabled = false;
            _hitSprite.mouseEnabled = false;
         }
         else
         {
            _avatarSprite.mouseEnabled = true;
            _hitSprite.mouseEnabled = true;
            _effect.visible = false;
            _thaneName.textFormatStyle = "colosseum.challengeMiddleView.thanename_t";
            setHitSprite();
         }
      }
      
      private function setHitSprite() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(_thaneName.x,_thaneName.y,_thaneName.textWidth,_thaneName.height);
         _hitSprite.graphics.endFill();
      }
      
      private function setFightNumberView(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_fightSprite,_fightBmp,24,25,15,24,"0123456789");
      }
      
      private function setRankNumberView(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_rankSprite,_rankBmd,24,25,15,24,"0123456789");
      }
      
      private function __onCompleteHandler() : void
      {
         var _loc1_:Object = _avatar.body.content;
         if(!_loc1_ || !_loc1_["pos_down"] || !_loc1_["pos_up"])
         {
            return;
         }
         _avatar.x = -_loc1_["pos_down"]["x"] * 0.8;
         _avatar.y = -_loc1_["pos_down"]["y"] * 0.8;
         _thaneName.x = _avatar.x + _loc1_["pos_up"]["x"] * 0.8 - _thaneName.textWidth / 2;
         _avatarSprite.addChild(_avatar);
         _fightImg.x = -(_fightImg.width + _fightSprite.width) / 2;
         _fightSprite.x = _fightImg.x + _fightImg.width;
         _rankSprite.x = -_rankSprite.width / 2;
         setHitSprite();
      }
      
      public function get avatar() : ShowAvatar
      {
         return _avatar;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_thaneName);
         _thaneName = null;
         ObjectUtils.disposeAllGrandson(_avatar);
         ObjectUtils.disposeAllChildren(_avatar);
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_cushion);
         _cushion = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_fightSprite);
         _fightSprite = null;
         ObjectUtils.disposeObject(_rankSprite);
         _rankSprite = null;
         _rankBmd.dispose();
         _rankBmd = null;
         _fightBmp.dispose();
         _fightBmp = null;
         ObjectUtils.disposeAllGrandson(_avatarSprite);
         ObjectUtils.disposeAllChildren(_avatarSprite);
         ObjectUtils.disposeObject(_avatarSprite);
         _avatarSprite = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_notInRank);
         _notInRank = null;
      }
   }
}

