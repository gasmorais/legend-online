package consortiachess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortiachess.ui.ChesspvpInLeftUI;
   import consortiachess.ui.ChesspvpInRightUI;
   import consortiachess.util.ChesspvpResourceUtil;
   import events.ConsortiaEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpOp;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ChesspvpInFrame extends Frame implements IManualSize
   {
      
      private var _leftView:ChesspvpInLeftUI;
      
      private var _rightView:ChesspvpInRightUI;
      
      private var _helpBtn:BaseButton;
      
      public function ChesspvpInFrame()
      {
         super();
         initView();
         initEvent();
         ChessPvpManager.Instance.operFun(ChessPvpOp.OP_OPEN);
      }
      
      private function initView() : void
      {
         ChesspvpResourceUtil.ins.initData();
         _leftView = new ChesspvpInLeftUI();
         _rightView = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.inRightView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.helpBtn");
         addToContent(_rightView);
         addToContent(_leftView);
         addToContent(_helpBtn);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,945,574);
      }
      
      private function get consortiaModel() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("CLOSECONSORTIAFRAME",quitConsortiaHandler);
         NotificationManager.instance.addEventListener(ChessPvpOp.EVENT_OP_FUN,funUpdateHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         consortiaModel.addEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("CLOSECONSORTIAFRAME",quitConsortiaHandler);
         NotificationManager.instance.removeEventListener(ChessPvpOp.EVENT_OP_FUN,funUpdateHandler);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
         consortiaModel.removeEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
      }
      
      private function __onMemberListUpdata(param1:ConsortiaEvent) : void
      {
         _rightView.onMemberListUpdata();
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.helpFrame");
         _loc2_.show();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         ChessPvpManager.Instance.operFun(ChessPvpOp.OP_CLOSE);
         super.__onCloseClick(param1);
      }
      
      private function funUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Array = param1.data as Array;
         var _loc2_:int = int(_loc3_[0]);
         switch(_loc2_)
         {
            case ChessPvpOp.OP_SIGN:
            case ChessPvpOp.OP_OPEN:
               _leftView.updateView();
               _rightView.updateView();
               break;
            case 0:
               _leftView.updateView();
               break;
            case ChessPvpOp.OP_EDIT:
               _rightView.updateView();
         }
      }
      
      private function quitConsortiaHandler(param1:NotificationEvent) : void
      {
         dispose();
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
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         ChesspvpResourceUtil.ins.clean();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("chesspvp.frame.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
   }
}

