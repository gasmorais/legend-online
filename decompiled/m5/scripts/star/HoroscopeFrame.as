package star
{
   import avatar.view.ShowAvatar;
   import bag.helper.BagHelper;
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.StarEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import star.view.EquipStarListView;
   import star.view.PlayerStarListView;
   import yishi.GlobalConfig;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.utils.GameDrag;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StarHelper;
   import yishi.view.frame.ConfirmSellFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class HoroscopeFrame extends Frame
   {
      
      public static const LOCK:int = 1;
      
      private var _bg:MutipleImage;
      
      private var _starPowBg:Bitmap;
      
      private var _starPow:FilterFrameText;
      
      private var _starPowView:StripView;
      
      private var _advanceStarbg:MutipleImage;
      
      private var _horoscopeEquipBg:Bitmap;
      
      private var _quickComposeBtn:IconButton;
      
      private var _composeLockBtn:IconButton;
      
      private var _subBtn:IconButton;
      
      private var _playerStarListView:PlayerStarListView;
      
      private var _equipStarListView:EquipStarListView;
      
      private var _figure:ShowAvatar;
      
      private var _isCloseBySatrFrame:Boolean;
      
      public var starFrame:StarFrame;
      
      private var _target:StarInfo;
      
      public function HoroscopeFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         NotificationManager.instance.sendNotification("STOP_EFFECT",false);
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.star.HoroscopeBackBg");
         _starPowView = ComponentFactory.Instance.creatComponentByStylename("star.HoroscopeStarPowView");
         _starPowView.tipData = {
            "starList":starManager.getStarListByBagType(2),
            "troughList":starManager.starModel.starTroughs
         };
         _starPowBg = ComponentFactory.Instance.creatBitmap("asset.star.PlayerStarPowBack");
         _starPow = ComponentFactory.Instance.creatComponentByStylename("star.StarPowTxt");
         _starPow.text = String(starManager.starModel.getStarPow());
         _horoscopeEquipBg = ComponentFactory.Instance.creatBitmap("asset.star.HoroscopeEquipBg");
         _advanceStarbg = ComponentFactory.Instance.creatComponentByStylename("star.advanceStarBg");
         _quickComposeBtn = ComponentFactory.Instance.creatComponentByStylename("star.QuickComposeBtn");
         _composeLockBtn = ComponentFactory.Instance.creatComponentByStylename("star.ComposeLockBtn");
         _subBtn = ComponentFactory.Instance.creatComponentByStylename("star.SubBtn");
         _figure = ComponentFactory.Instance.creatCustomObject("star.HoroscopeShowAvatar");
         _playerStarListView = ComponentFactory.Instance.creatCustomObject("star.HoroscopePlayerStarListView");
         _equipStarListView = ComponentFactory.Instance.creatCustomObject("star.HoroscopeEquipStarListView");
         addToContent(_bg);
         addToContent(_figure);
         addToContent(_horoscopeEquipBg);
         addToContent(_advanceStarbg);
         addToContent(_equipStarListView);
         addToContent(_playerStarListView);
         addToContent(_quickComposeBtn);
         addToContent(_composeLockBtn);
         addToContent(_subBtn);
         _starPowView.addChild(_starPowBg);
         _starPowView.addChild(_starPow);
         addToContent(_starPowView);
         _quickComposeBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.quickComposeTip");
         _composeLockBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.composeLockTip");
         _subBtn.visible = thane.vocationGrades > 0;
      }
      
      protected function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         starManager.addEventListener("UPDATE_STAR_POWER",__updateStarPowHandler);
         _quickComposeBtn.addEventListener("click",__quickComposeClick);
         _composeLockBtn.addEventListener("click",__composeLockClick);
         _subBtn.addEventListener("click",__subBtnClick);
         NotificationManager.instance.addEventListener("REFRESH_STARTROUGHINFO",_refreshStarValue);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         starManager.removeEventListener("UPDATE_STAR_POWER",__updateStarPowHandler);
         if(_quickComposeBtn)
         {
            _quickComposeBtn.removeEventListener("click",__quickComposeClick);
         }
         if(_composeLockBtn)
         {
            _composeLockBtn.removeEventListener("click",__composeLockClick);
         }
         if(_subBtn)
         {
            _subBtn.removeEventListener("click",__subBtnClick);
         }
         NotificationManager.instance.removeEventListener("REFRESH_STARTROUGHINFO",_refreshStarValue);
      }
      
      private function _refreshStarValue(param1:NotificationEvent) : void
      {
         _starPow.text = String(starManager.starModel.getStarPow());
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(starFrame)
               {
                  starFrame.hideHoroscopeFrame();
                  break;
               }
               dispose();
         }
      }
      
      private function __updateStarPowHandler(param1:StarEvent) : void
      {
         _starPow.text = String(starManager.starModel.getStarPow());
         _starPowView.tipData = {
            "starList":starManager.getStarListByBagType(2),
            "troughList":starManager.starModel.starTroughs
         };
      }
      
      private function __quickComposeClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc9_:StarInfo = null;
         var _loc11_:TodayNotAlertFrame = null;
         var _loc8_:String = null;
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         if(starManager.getStarListByBagType(1).getList().length <= 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc7_:int = 0;
         var _loc6_:SimpleDictionary = starManager.getStarListByBagType(1);
         for each(var _loc10_:StarInfo in _loc6_)
         {
            if(!_loc10_.composeLock && _loc10_.grade < 10 && _loc10_.template.Profile < 8)
            {
               _loc7_ += StarHelper.getStarTotalExp(_loc10_);
               if(_loc10_.grade < StarHelper.getStarMaxGradeByProfile(_loc10_.template.Profile))
               {
                  if(_loc10_.template.Profile != 6)
                  {
                     if(!_loc9_)
                     {
                        _loc9_ = _loc10_;
                     }
                     else
                     {
                        _loc9_ = _loc10_;
                        _loc9_.template.Profile < _loc10_.template.Profile ? _loc9_ : _loc9_;
                     }
                  }
               }
            }
         }
         if(!_loc9_ || (_loc7_ -= StarHelper.getStarTotalExp(_loc9_)) <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc5_:String = StarHelper.getStarHtmlName(_loc9_.template);
         var _loc4_:int = int(StarHelper.checkCanUpGrade(_loc7_,_loc9_));
         _loc2_ = _loc5_ + LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command02",_loc7_);
         if(_loc4_ > _loc9_.grade)
         {
            _loc2_ += LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command05",_loc4_);
         }
         _target = _loc9_;
         if(!StarManager.isNotAlert)
         {
            _loc11_ = ComponentFactory.Instance.creatComponentByStylename("star.composeNotAlert");
            _loc8_ = _loc2_;
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc11_.show(_loc8_,_loc3_,__quickComposeResponse,null,"center",2,true);
            return;
         }
         __quickComposeResponse(true);
      }
      
      private function __quickComposeResponse(param1:Boolean) : void
      {
         var _loc8_:ConfirmSellFrame = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         if(param1)
         {
            StarManager.isNotAlert = true;
         }
         var _loc3_:StarInfo = _target;
         var _loc2_:Array = [];
         var _loc5_:SimpleDictionary = starManager.getStarListByBagType(1);
         for each(var _loc7_:StarInfo in _loc5_)
         {
            if(_loc7_ != _loc3_ && !_loc7_.composeLock && _loc7_.template.Profile >= 5 && _loc7_.template.Profile != 6 && _loc7_.template.Profile < 8 && _loc7_.grade < 10)
            {
               _loc2_.push(_loc7_);
            }
         }
         if(_loc2_.length > 0)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellFrame");
            _loc6_ = "";
            _loc4_ = "";
            for each(_loc7_ in _loc2_)
            {
               _loc4_ += StarHelper.getStarHtmlName(_loc7_.template);
            }
            _loc6_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip",_loc4_) + "\n" + LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.content.htmlText02") + "<font color=\'#01ccff\'>[YES]</font>" + LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip2");
            _loc8_.show(_loc6_,_loc3_,quickComposeCall);
            return;
         }
         quickComposeCall(true);
      }
      
      private function quickComposeCall(param1:Boolean, param2:Boolean = false, param3:Object = null) : void
      {
         if(param1)
         {
            param3 = _target;
            starManager.sendQuickCompose(param3.pos);
         }
      }
      
      private function __subBtnClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("star",5);
         FrameControllerManager.instance.starController.setPreFrame("star",null);
      }
      
      private function __composeLockClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.isDuringResetTime)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description1");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.hasVicePassword == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",1);
         }
         else
         {
            SoundManager.instance.play("022");
            param1.stopPropagation();
            param1.stopImmediatePropagation();
            if(GlobalConfig.isConfirmPassword)
            {
               BagHelper.instance.vpLockBtnClickHandler(this);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("vicepassword",3);
            }
         }
      }
      
      private function createDragByType(param1:int) : void
      {
         var _loc3_:DisplayObject = getDragIconByType(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{"icon":_loc3_});
         _loc2_.dropChecks = [StarBagCell,Stage];
         switch(param1 - 1)
         {
            case 0:
               _loc2_.onDrop = onLockDrop;
         }
         CursorManagerII.instance.hide();
      }
      
      private function getDragIconByType(param1:int) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.LockIconAsset");
         }
         _loc2_.mouseEnabled = _loc2_.mouseChildren = true;
         return _loc2_;
      }
      
      private function onLockDrop(param1:GameDrag) : void
      {
         param1.stopImmediatePropagation();
         CursorManagerII.instance.show();
         var _loc2_:StarBagCell = param1.dropTarget as StarBagCell;
         if(_loc2_ && !_loc2_.lock && _loc2_.data)
         {
            starManager.sendStarComposeLock(_loc2_.data.bagType,_loc2_.data.pos);
         }
      }
      
      private function refreshView() : void
      {
         _figure.data = thane;
      }
      
      public function show(param1:* = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         DragManager.getInstance().stopDrag();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_starPowBg);
         _starPowBg = null;
         ObjectUtils.disposeObject(_horoscopeEquipBg);
         _horoscopeEquipBg = null;
         if(_starPow)
         {
            _starPow.dispose();
         }
         _starPow = null;
         if(_starPowView)
         {
            _starPowView.dispose();
         }
         _starPowView = null;
         if(_quickComposeBtn)
         {
            _quickComposeBtn.dispose();
         }
         _quickComposeBtn = null;
         if(_composeLockBtn)
         {
            _composeLockBtn.dispose();
         }
         _composeLockBtn = null;
         if(_playerStarListView)
         {
            _playerStarListView.dispose();
         }
         _playerStarListView = null;
         if(_equipStarListView)
         {
            _equipStarListView.dispose();
         }
         _equipStarListView = null;
         ObjectUtils.disposeViolentMc(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_advanceStarbg);
         _advanceStarbg = null;
         ObjectUtils.disposeObject(_subBtn);
         _subBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_isCloseBySatrFrame)
         {
         }
         NotificationManager.instance.sendNotification("STOP_EFFECT",true);
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         if(BagHelper.instance.isVpLock)
         {
            BagHelper.instance.vpLockBtnClickHandler(this);
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
      }
   }
}

