package darkmaze
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.darkmaze.DarkMazeModel;
   import mvc.module.darkmaze.DarkMazeNodeInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.DarkMazeEventTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   
   public class DarkMazeBuyFrame extends Frame
   {
      
      private var _hbox:HBox;
      
      private var _nodeId:int;
      
      private var _nodeType:int;
      
      private var _darkMazeEventTemp:DarkMazeEventTemplateInfo;
      
      public function DarkMazeBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _hbox = ComponentFactory.Instance.creatComponentByStylename("darkMazeBuyFrame.hbox");
         addToContent(_hbox);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
      }
      
      private function _refreshView(param1:NotificationEvent) : void
      {
         var _loc2_:DarkMazeBuyItemView = null;
         var _loc3_:Array = null;
         if(_hbox)
         {
            _hbox.removeAllChild();
         }
         if(!StringHelper.isNullOrEmpty(_darkMazeEventTemp.Param1))
         {
            _loc2_ = new DarkMazeBuyItemView();
            _loc2_.index = 1;
            _loc2_.nodeId = _nodeId;
            _loc2_.nodeType = _nodeType;
            _loc3_ = _darkMazeEventTemp.Param1.split(",");
            _loc2_.dataArr = _loc3_;
            _hbox.addChild(_loc2_);
            _hbox.x = 170;
         }
         if(!StringHelper.isNullOrEmpty(_darkMazeEventTemp.Param2))
         {
            _loc2_ = new DarkMazeBuyItemView();
            _loc2_.index = 2;
            _loc2_.nodeId = _nodeId;
            _loc2_.nodeType = _nodeType;
            _loc3_ = _darkMazeEventTemp.Param2.split(",");
            _loc2_.dataArr = _loc3_;
            _hbox.addChild(_loc2_);
            _hbox.x = 100;
         }
         if(!StringHelper.isNullOrEmpty(_darkMazeEventTemp.Param3))
         {
            _loc2_ = new DarkMazeBuyItemView();
            _loc2_.index = 3;
            _loc2_.nodeId = _nodeId;
            _loc2_.nodeType = _nodeType;
            _loc3_ = _darkMazeEventTemp.Param3.split(",");
            _loc2_.dataArr = _loc3_;
            _hbox.addChild(_loc2_);
            _hbox.x = 10;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("DARK_MAZE_SHOP_BUY_UPDATE",_refreshView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("DARK_MAZE_SHOP_BUY_UPDATE",_refreshView);
      }
      
      private function canCloseFrame() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:Array = model.buyInfoArr;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_] == 1)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         if(_loc3_ >= 3)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         var _loc2_:DarkMazeNodeInfo = null;
         titleText = LanguageMgr.GetTranslation("darkmaze.DarkMazeBuyFrame.titleText");
         if(param1 && param1.frameData)
         {
            _loc2_ = param1.frameData as DarkMazeNodeInfo;
            if(_loc2_)
            {
               _nodeId = _loc2_.nodeId;
               _darkMazeEventTemp = _loc2_.eventTemp;
               _nodeType = _loc2_.eventTemp.EventType;
            }
         }
         _refreshView(null);
         DarkMazeManager.instance.darkMazeOperation(2,_nodeId,0);
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
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(!canCloseFrame())
               {
                  SimpleAlertHelper.instance.data = [closeBuyFrame];
                  _loc3_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc2_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc5_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc4_ = LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.closeBuyFrmeTips");
                  SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc3_,_loc2_,true,false,false,2,"SIMPLE_ALERT");
                  break;
               }
               model.moveToTargetNode(_nodeId,_nodeType);
               dispose();
         }
      }
      
      private function closeBuyFrame(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_nodeId == 2)
            {
               DarkMazeManager.instance.darkMazeOperation(2,_nodeId,1);
            }
            else
            {
               model.moveToTargetNode(_nodeId,_nodeType);
            }
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

