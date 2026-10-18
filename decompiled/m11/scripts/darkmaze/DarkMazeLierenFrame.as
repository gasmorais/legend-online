package darkmaze
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.darkmaze.DarkMazeModel;
   import mvc.module.darkmaze.DarkMazeNodeInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.DarkMazeEventTemplateInfo;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DarkMazeLierenFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _txt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _hbox:HBox;
      
      private var _nodeId:int;
      
      private var _nodeInfo:DarkMazeNodeInfo;
      
      public function DarkMazeLierenFrame()
      {
         super();
         model.selectedChildId = 0;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenFrame.bg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenFrame.txt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenFrame.confirmBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenFrame.hbox");
         addToContent(_bg);
         addToContent(_txt);
         addToContent(_confirmBtn);
         addToContent(_hbox);
         _txt.text = LanguageMgr.GetTranslation("darkmaze.darkMazeLierenFrame.txt");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmBtnHandler);
         }
         DarkMazeManager.instance.model.addEventListener("UPDATE_SELECT_CHILDINFO",__updateView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
         DarkMazeManager.instance.model.removeEventListener("UPDATE_SELECT_CHILDINFO",__updateView);
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         if(model.selectedChildId == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.darkMazeLierenFrame.click"));
            return;
         }
         if(_nodeId == 2)
         {
            DarkMazeManager.instance.darkMazeOperation(2,_nodeId,model.selectedChildId);
         }
         else
         {
            model.moveToTargetNode(_nodeId,_nodeInfo.eventTemp.EventType);
         }
         dispose();
      }
      
      private function __updateView(param1:Event) : void
      {
         var _loc2_:DarkMazeLierenItemView = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _hbox.numChildren)
         {
            _loc2_ = _hbox.getChildAt(_loc3_) as DarkMazeLierenItemView;
            if(_loc2_ && _loc2_.data && _loc2_.data.childId == model.selectedChildId)
            {
               _loc2_.selectedFlag = true;
            }
            else
            {
               _loc2_.selectedFlag = false;
            }
            _loc3_++;
         }
      }
      
      private function initData() : void
      {
         var _loc2_:DarkMazeLierenItemView = null;
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _hbox.disposeAllChildren();
         var _loc1_:DarkMazeEventTemplateInfo = _nodeInfo.eventTemp;
         if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.Param1))
         {
            _loc5_ = _loc1_.Param1.split(",");
            _loc3_ = int(_loc5_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = new DarkMazeLierenItemView();
               _loc2_.data = model.getChildById(_loc5_[_loc4_]);
               _loc2_.selectedFlag = false;
               _hbox.addChild(_loc2_);
               _loc4_++;
            }
         }
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         if(param1 && param1.frameData)
         {
            _nodeInfo = param1.frameData as DarkMazeNodeInfo;
            if(_nodeInfo)
            {
               _nodeId = _nodeInfo.nodeId;
            }
         }
         initData();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : DarkMazeModel
      {
         return DarkMazeManager.instance.model;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

