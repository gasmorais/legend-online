package map.internals.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.internals.data.WildLand;
   import map.internals.interfaces.IOuterFrame;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.TimeDownView;
   
   public class FieldInfoView extends Sprite implements IOuterFrame
   {
      
      private var _frameId:uint;
      
      private var _currentTime:int;
      
      protected var _frame:Frame;
      
      protected var _wildLand:WildLand;
      
      private var _attackBtn:TextButton;
      
      private var _moveBtn:TextButton;
      
      private var _baseBackGround:ScaleBitmapImage;
      
      private var _loadIcon:DisplayObject;
      
      private var _buildingBG:Image;
      
      private var _timeDown:TimeDownView;
      
      private var _wildTeamFrameNameText:FilterFrameText;
      
      private var _remainingTimeFrameText:FilterFrameText;
      
      private var _occupationLordsFrameText:FilterFrameText;
      
      private var _occupationLordsFrameText2:FilterFrameText;
      
      private var _goldText:FilterFrameText;
      
      private var _goldText2:FilterFrameText;
      
      private var _goldText3:FilterFrameText;
      
      public function FieldInfoView()
      {
         super();
         _frameId = 2;
         init();
      }
      
      private function init() : void
      {
         _baseBackGround = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.FieldBgAsset");
         addChild(_baseBackGround);
         _buildingBG = ComponentFactory.Instance.creatComponentByStylename("outercity.goldBG");
         addChild(_buildingBG);
         _wildTeamFrameNameText = ComponentFactory.Instance.creatComponentByStylename("outercity.WildTeamFrameNameText");
         addChild(_wildTeamFrameNameText);
         _remainingTimeFrameText = ComponentFactory.Instance.creatComponentByStylename("outercity.RemainingTimeFrameText");
         var _loc4_:String = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.remainintTimeFrameTextText");
         _remainingTimeFrameText.text = _loc4_;
         addChild(_remainingTimeFrameText);
         _timeDown = ComponentFactory.Instance.creatComponentByStylename("outercity.TimeDownView");
         addChild(_timeDown);
         _occupationLordsFrameText = ComponentFactory.Instance.creatComponentByStylename("outercity.OccupationLordsFrameText");
         var _loc2_:String = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.occupationLordsFrameTextText");
         _occupationLordsFrameText.text = _loc2_;
         addChild(_occupationLordsFrameText);
         _occupationLordsFrameText2 = ComponentFactory.Instance.creatComponentByStylename("outercity.OccupationLordsFrameText2");
         addChild(_occupationLordsFrameText2);
         _goldText = ComponentFactory.Instance.creatComponentByStylename("outercity.OccupationFrameGoldText");
         addChild(_goldText);
         var _loc5_:String = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.goldTextText");
         _goldText.text = _loc5_;
         _goldText2 = ComponentFactory.Instance.creatComponentByStylename("outercity.OccupationFrameGoldText2");
         addChild(_goldText2);
         _goldText3 = ComponentFactory.Instance.creatComponentByStylename("outercity.OccupationFrameGoldText3");
         addChild(_goldText3);
         _goldText3.text = "/" + LanguageMgr.GetTranslation("public.time.hour");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.FieldAttackBtnAsset");
         var _loc1_:String = LanguageMgr.GetTranslation("public.attack");
         _attackBtn.text = _loc1_;
         addChild(_attackBtn);
         _moveBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.FieldMoveBtnAsset");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         _moveBtn.text = _loc3_;
         addChild(_moveBtn);
      }
      
      private function getTipContent(param1:MovieClip) : DisplayObject
      {
         return null;
      }
      
      protected function __attackHandler(param1:MouseEvent) : void
      {
         throw new Error("override __attackHandler(evt : MouseEvent)");
      }
      
      protected function __moveHandler(param1:MouseEvent) : void
      {
         throw new Error("override __moveHandler(evt : MouseEvent)");
      }
      
      public function show(param1:Object) : void
      {
         _wildLand = param1 as WildLand;
         if(!_frame)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.FieldFrame");
         }
         _frame.beginChanges();
         _frame.titleText = LanguageMgr.GetTranslation("public.level.name",_wildLand.tempInfo.MapPhysicsTempName,_wildLand.tempInfo.Grades);
         _frame.commitChanges();
         _frame.addToContent(this);
         LayerManager.Instance.addToLayer(_frame,3,true,true,1);
         loadMovie();
         showInfo();
         KeyBoardRegister.instance.keyEnable = false;
         addEvent();
      }
      
      private function loadMovie() : void
      {
         var _loc1_:String = PathManager.solveMapPhysicsBySonType(_wildLand.tempInfo.SonType);
         LoaderManagerII.instance.load(_loc1_,2,8,__loadCompleteHanlder);
      }
      
      private function __loadCompleteHanlder(param1:LoaderInfo, param2:Object) : void
      {
         removeLoad();
         if(!parent)
         {
            return;
         }
         _loadIcon = param2 as DisplayObject;
         addChild(_loadIcon);
         var _loc3_:Rectangle = _loadIcon.getBounds(_loadIcon);
         var _loc4_:Number = 80 / _loc3_.width;
         _loc4_ = 80 / _loc3_.height > _loc4_ ? _loc4_ : 80 / _loc3_.height;
         _loadIcon.scaleX = _loadIcon.scaleY = _loc4_;
         _loadIcon.x = 40;
         _loadIcon.y = 70;
      }
      
      private function removeLoad() : void
      {
         ObjectUtils.disposeViolentMc(_loadIcon as DisplayObjectContainer);
         _loadIcon = null;
      }
      
      public function get timeLeft() : int
      {
         return 0;
      }
      
      public function set timeLeft(param1:int) : void
      {
      }
      
      private function get mapName() : String
      {
         return TempleteManager.instance.mapTemplateCate.getTemplateByID(_wildLand.info.mapId).MapName;
      }
      
      public function showInfo() : void
      {
         var _loc7_:String = null;
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         _wildTeamFrameNameText.text = _wildLand.tempInfo.MapPhysicsTempName + "(" + _wildLand.convertX + "," + _wildLand.convertY + ") " + mapName;
         if(_wildLand.info.occupyPlayerId == 0)
         {
            _loc7_ = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.occupationLordsFrameText2Text1");
            _occupationLordsFrameText2.text = _loc7_;
            _loc1_ = LanguageMgr.GetTranslation("public.attack");
            _attackBtn.text = _loc1_;
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.occupationLordsFrameText2Text2");
            _occupationLordsFrameText2.text = _wildLand.info.occupyPlayerName || _loc3_;
            if(_wildLand.info.occupyPlayerId == thane.userId)
            {
               _loc5_ = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.attackBtnText1");
               _attackBtn.text = _loc5_;
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("public.attack");
               _attackBtn.text = _loc4_;
            }
         }
         _goldText2.text = "+" + _wildLand.tempInfo.Property4;
         _goldText3.x = _goldText2.x + _goldText2.textWidth;
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc6_:int = int(_wildLand.createDate.time);
         _loc6_ = _loc2_ - _loc6_;
         var _loc8_:int = int(_wildLand.tempInfo.RefreshTime);
         _loc8_ = _loc8_ - _loc6_ / 1000;
         _loc8_ = int(_loc8_ < 0 ? 0 : _loc8_);
         _timeDown.timeCount = _loc8_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function addEvent() : void
      {
         _frame.addEventListener("response",__frameEvent);
         _attackBtn.addEventListener("click",__attackHandler);
         _moveBtn.addEventListener("click",__moveHandler);
      }
      
      private function removeEvent() : void
      {
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",__attackHandler);
         }
         if(_moveBtn)
         {
            _moveBtn.removeEventListener("click",__moveHandler);
         }
         if(_frame)
         {
            _frame.removeEventListener("response",__frameEvent);
         }
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               close();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeLoad();
         _wildLand = null;
         if(_attackBtn)
         {
            _attackBtn.dispose();
         }
         _attackBtn = null;
         if(_moveBtn)
         {
            _moveBtn.dispose();
         }
         _moveBtn = null;
         if(_baseBackGround)
         {
            _baseBackGround.dispose();
         }
         _baseBackGround = null;
         if(_buildingBG)
         {
            _buildingBG.dispose();
         }
         _buildingBG = null;
         if(_wildTeamFrameNameText)
         {
            _wildTeamFrameNameText.dispose();
         }
         _wildTeamFrameNameText = null;
         if(_remainingTimeFrameText)
         {
            _remainingTimeFrameText.dispose();
         }
         _remainingTimeFrameText = null;
         if(_occupationLordsFrameText)
         {
            _occupationLordsFrameText.dispose();
         }
         _occupationLordsFrameText = null;
         if(_occupationLordsFrameText2)
         {
            _occupationLordsFrameText2.dispose();
         }
         _occupationLordsFrameText2 = null;
         if(_goldText)
         {
            _goldText.dispose();
         }
         _goldText = null;
         if(_goldText2)
         {
            _goldText2.dispose();
         }
         _goldText2 = null;
         if(_goldText3)
         {
            _goldText3.dispose();
         }
         _goldText3 = null;
         if(_timeDown)
         {
            ObjectUtils.disposeObject(_timeDown);
         }
         _timeDown = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
      }
      
      public function close() : void
      {
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      public function get info() : WildLand
      {
         return _wildLand;
      }
      
      public function get attackBtn() : BaseButton
      {
         return _attackBtn;
      }
      
      public function get frameId() : uint
      {
         return _frameId;
      }
   }
}

