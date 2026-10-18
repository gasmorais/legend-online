package darkmaze
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import managers.YearActiveManager;
   import mvc.module.darkmaze.DarkMazeModel;
   import mvc.module.darkmaze.DarkMazeNodeInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DarkMazeNodeItemView extends Component
   {
      
      private var _typeImage:ScaleFrameImage;
      
      private var _bg:Image;
      
      private var _filter:UIFilter;
      
      private var _nodeId:int;
      
      private var _indexPosX:int;
      
      private var _indexPosY:int;
      
      private var _typeImageVisible:Boolean;
      
      private var _data:DarkMazeNodeInfo;
      
      private var _moveOutMc:MovieClip;
      
      private var _lockMc:MovieClip;
      
      private var _index:int;
      
      private var _lockImag:Image;
      
      private var _sprite:Sprite;
      
      public function DarkMazeNodeItemView(param1:int, param2:int, param3:int)
      {
         super();
         _nodeId = param1;
         _indexPosX = param2;
         _indexPosY = param3;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("darkMazeNodeItemView.bg");
         _typeImage = ComponentFactory.Instance.creatComponentByStylename("darkMazeNodeItemView.typeImage");
         _lockImag = ComponentFactory.Instance.creatComponentByStylename("darkMazeNodeItemView.lockImage");
         _moveOutMc = ComponentFactory.Instance.creatCustomObject("asset.darkmaze.moveOutMc");
         _lockMc = ComponentFactory.Instance.creatCustomObject("asset.darkmaze.lockMc");
         _lockMc.gotoAndStop(1);
         _filter = new UIFilter();
         addChild(_bg);
         addChild(_typeImage);
         addChild(_lockImag);
         _lockImag.visible = false;
         addChild(_lockMc);
         _lockMc.visible = false;
         addChild(_moveOutMc);
         _moveOutMc.play();
         _moveOutMc.visible = false;
         _sprite = new Sprite();
         _sprite.graphics.clear();
         _sprite.graphics.beginFill(0,0);
         _sprite.graphics.drawRect(5,45,94,104);
         _sprite.graphics.endFill();
         addChild(_sprite);
         _lockMc.x = 16;
         _lockMc.y = 46;
         _moveOutMc.x = -40;
         _moveOutMc.y = 0;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_typeImage);
         _typeImage = null;
         ObjectUtils.disposeViolentMc(_lockMc);
         _lockMc = null;
         ObjectUtils.disposeViolentMc(_moveOutMc);
         _moveOutMc = null;
         ObjectUtils.disposeObject(_lockImag);
         _lockImag = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
      }
      
      private function addEvent() : void
      {
         _sprite.addEventListener("click",__moveHandler);
         this.addEventListener("mouseOver",__playMoveMcHandler);
         this.addEventListener("mouseOut",__stopMoveMcHander);
      }
      
      private function removeEvent() : void
      {
         _sprite.removeEventListener("click",__moveHandler);
         this.removeEventListener("mouseOver",__playMoveMcHandler);
         this.removeEventListener("mouseOut",__stopMoveMcHander);
      }
      
      private function __playMoveMcHandler(param1:MouseEvent) : void
      {
         if(_moveOutMc && _data && _data.nodeId > model.currentNodeId)
         {
            _moveOutMc.visible = true;
         }
      }
      
      public function setLockImgeVisible(param1:Boolean) : void
      {
         _lockImag.visible = param1;
      }
      
      private function __stopMoveMcHander(param1:MouseEvent) : void
      {
         if(_moveOutMc)
         {
            _moveOutMc.visible = false;
         }
      }
      
      public function playMc() : void
      {
         TweenMax.to(_typeImage,0.5,{
            "alpha":0,
            "onComplete":backCall
         });
      }
      
      private function backCall() : void
      {
         _lockMc.visible = true;
         _lockMc.play();
         _lockMc.addFrameScript(_lockMc.totalFrames - 1,__playLockCompleteHander);
      }
      
      private function __playLockCompleteHander() : void
      {
         _lockMc.visible = false;
         _lockMc.gotoAndStop(1);
         _lockImag.visible = true;
         if(model.moveTargetNodeType == 6)
         {
            DarkMazeManager.instance.darkMazeOperation(2,model.moveTargetNodeId,model.selectedChildId);
         }
         else if(model.moveTargetNodeType == 7)
         {
            DarkMazeManager.instance.darkMazeOperation(2,model.moveTargetNodeId,1);
         }
         else
         {
            DarkMazeManager.instance.darkMazeOperation(2,model.moveTargetNodeId);
         }
      }
      
      private function __moveHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(model.currentNodeId == _nodeId)
         {
            return;
         }
         if(_moveOutMc)
         {
            _moveOutMc.visible = false;
         }
         if(model.currentNodeId == 1 && model.currentLayer == 1)
         {
            SimpleAlertHelper.instance.data = [confirm];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc2_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.firstWalkTxt");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc3_,_loc2_,true,false,false,2,"SIMPLE_ALERT");
         }
         else
         {
            walkHander();
         }
      }
      
      private function walkHander() : void
      {
         var _loc3_:String = null;
         if(_data.nodeId < model.currentNodeId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.click"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc1_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_data.eventTemp && _data.eventTemp.EventType == 0)
         {
            SimpleAlertHelper.instance.data = [confirmWalk];
            _loc3_ = LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.WalkConfirmTxt");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc3_,_loc2_,_loc1_,true,false,false,2,"SIMPLE_ALERT");
         }
         else if(_data.eventTemp && _data.eventTemp.EventType == 7)
         {
            SimpleAlertHelper.instance.data = [openBuyFrame];
            _loc3_ = LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.openBuyFrameTxt");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc3_,_loc2_,_loc1_,true,false,false,2,"SIMPLE_ALERT");
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("darkmaze",_data.eventTemp.EventType,_data);
         }
      }
      
      private function openBuyFrame(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("darkmaze",_data.eventTemp.EventType,_data);
         }
      }
      
      private function confirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            walkHander();
         }
      }
      
      private function confirmWalk(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_data.nodeId == 2)
            {
               DarkMazeManager.instance.darkMazeOperation(2,_data.nodeId);
            }
            else
            {
               model.moveToTargetNode(_data.nodeId,_data.eventTemp.EventType);
            }
         }
      }
      
      public function set typeImageVisible(param1:Boolean) : void
      {
         _typeImage.visible = param1;
      }
      
      public function refreshView(param1:Boolean) : void
      {
         _moveOutMc.visible = false;
         if(param1)
         {
            _data.isLight = true;
            _filter.setLightingFilter(this);
            this.mouseEnabled = true;
            this.mouseChildren = true;
            this.buttonMode = true;
         }
         else
         {
            _data.isLight = false;
            _filter.setGrayFilter(this);
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this.buttonMode = false;
         }
         if(YearActiveManager.ins.isOpen)
         {
            if(_data.eventTemp.EventType == 1 || _data.eventTemp.EventType == 2 || _data.eventTemp.EventType == 3)
            {
               _filter.setLightingFilter(this);
               this.mouseEnabled = true;
               this.mouseChildren = true;
               this.buttonMode = true;
            }
         }
      }
      
      public function set data(param1:DarkMazeNodeInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(_data.nodeId == model.currentNodeId)
         {
            _typeImage.setFrame(9);
         }
         else
         {
            _typeImage.setFrame(_data.eventTemp.EventType + 1);
         }
      }
      
      private function get model() : DarkMazeModel
      {
         return DarkMazeManager.instance.model;
      }
      
      public function get indexPosY() : int
      {
         return _indexPosY;
      }
      
      public function get indexPosX() : int
      {
         return _indexPosX;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _data = null;
      }
   }
}

