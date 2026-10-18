package darkmaze
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.darkmaze.DarkMazeNodeInfo;
   import yishi.datas.ComponentGroupType;
   
   public class DarkMazeDemonFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _descTxt1:FilterFrameText;
      
      private var _descTxt2:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _nodeId:int;
      
      public function DarkMazeDemonFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("darkMazeDemonFrame.bg");
         _descTxt1 = ComponentFactory.Instance.creatComponentByStylename("darkMazeSpringFrame.descTxt1");
         _descTxt2 = ComponentFactory.Instance.creatComponentByStylename("darkMazeSpringFrame.descTxt2");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("darkMazeDemonFrame.confirmBtn");
         addToContent(_bg);
         addToContent(_confirmBtn);
         addToContent(_descTxt1);
         addToContent(_descTxt2);
         _descTxt1.text = LanguageMgr.GetTranslation("darkmaze.darkMazeDemonFrame.descTxt1");
         _descTxt2.text = LanguageMgr.GetTranslation("darkmaze.darkMazeDemonFrame.descTxt2");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_descTxt1);
         _descTxt1 = null;
         ObjectUtils.disposeObject(_descTxt2);
         _descTxt2 = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         if(_nodeId == 2)
         {
            DarkMazeManager.instance.darkMazeOperation(2,_nodeId);
         }
         else
         {
            DarkMazeManager.instance.model.moveToTargetNode(_nodeId);
         }
         dispose();
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         var _loc2_:DarkMazeNodeInfo = null;
         if(param1 && param1.frameData)
         {
            _loc2_ = param1.frameData as DarkMazeNodeInfo;
            if(_loc2_)
            {
               _nodeId = _loc2_.nodeId;
            }
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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

