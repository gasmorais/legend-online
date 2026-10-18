package maze.order
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class MazeOrderFrame extends Frame
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleLeftRightImage;
      
      private var _closeBtn:SelectedCheckButton;
      
      private var _list:MazeOrderView;
      
      public function MazeOrderFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("maze.order.MazeOrderBack1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("maze.order.MazeOrderBack2");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("maze.order.MazeOrderCloseBtn");
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         _list = new MazeOrderView();
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_list);
         addToContent(_closeBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _closeBtn.addEventListener("click",__onCloseClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _closeBtn.removeEventListener("click",__onCloseClick);
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
      
      public function show(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            titleText = LanguageMgr.GetTranslation("maze.order.MazeOrderFrame.title");
         }
         else if(param1 == 1)
         {
            titleText = LanguageMgr.GetTranslation("maze.order.MazeOrderFrame.title2");
         }
         else if(param1 == 2)
         {
            titleText = LanguageMgr.GetTranslation("maze.order.MazeOrderFrame.title3");
         }
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_list)
         {
            _list.dispose();
         }
         _list = null;
         if(_back1)
         {
            _back1.dispose();
         }
         _back1 = null;
         if(_back2)
         {
            _back2.dispose();
         }
         _back2 = null;
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         super.dispose();
      }
   }
}

