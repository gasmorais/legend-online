package consortia.view.crossguild.war
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import yishi.utils.MsgMan;
   
   public class CrossGuildUIView extends Component
   {
      
      private var _topView:CrossGuildWarTopView;
      
      private var _leftView:CrossGuildWarLeftView;
      
      public function CrossGuildUIView()
      {
         super();
         initView();
         addEvent();
         resizeHandler();
         __warInfoChangeHandler(null,null);
      }
      
      private function initView() : void
      {
         _topView = ComponentFactory.Instance.creatCustomObject("CrossGuildUIView.topView");
         _leftView = ComponentFactory.Instance.creatCustomObject("CrossGuildUIView.leftView");
         addChild(_topView);
         _topView.addChild(_leftView);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         MsgMan.addObserver("WAR_MAIN_CHANGE",this,__warInfoChangeHandler);
         MsgMan.addObserver("WAR_OHTER_INFO_CHANGE",this,__warInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         MsgMan.removeObserver("WAR_MAIN_CHANGE",this,__warInfoChangeHandler);
         MsgMan.removeObserver("WAR_OHTER_INFO_CHANGE",this,__warInfoChangeHandler);
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         _topView.x = (StageReferance.stageWidth - 859) / 2;
      }
      
      private function __warInfoChangeHandler(param1:String, param2:Object) : void
      {
         _topView.refreshView();
         _leftView.refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         super.dispose();
      }
   }
}

