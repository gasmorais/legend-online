package sort
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.SortEvent;
   import manager.LanguageMgr;
   import mvc.controler.SortController;
   import mvc.module.sort.SortModel;
   import yishi.manager.FrameControllerManager;
   
   public class SortFrame extends Frame
   {
      
      private var _leftBg:ScaleBitmapImage;
      
      private var _leftView:SortLeftview;
      
      private var _rightView:SortRightView;
      
      private var _regressRightView:RegressRightView;
      
      private var _mySortView:MySortView;
      
      private var _model:SortModel;
      
      private var _controller:SortController;
      
      private var _isShowNumOne:Boolean = false;
      
      public function SortFrame()
      {
         super();
         initView();
         addEvent();
         __tabSelectedHandler(null);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _isShowNumOne = false;
         _controller = FrameControllerManager.instance.sortController;
         _model = _controller.model;
         titleText = LanguageMgr.GetTranslation("mainBar.SmallMapBar.rankingBtnTipData");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("sort.LeftViewBg");
         _mySortView = ComponentFactory.Instance.creatCustomObject("sort.MySortView",[_model]);
         _leftView = ComponentFactory.Instance.creatCustomObject("sort.SortLeftview",[_model,_controller,numberOneShow]);
         _rightView = ComponentFactory.Instance.creatCustomObject("sort.SortRightView",[_model,_controller]);
         _regressRightView = ComponentFactory.Instance.creatCustomObject("sort.RegressRightView",[_model,_controller]);
         _regressRightView.visible = false;
         addToContent(_leftBg);
         addToContent(_rightView);
         addToContent(_regressRightView);
         addToContent(_mySortView);
         addToContent(_leftView);
      }
      
      private function numberOneShow() : void
      {
         _isShowNumOne = true;
         dispose();
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_regressRightView);
         _regressRightView = null;
         ObjectUtils.disposeObject(_mySortView);
         _mySortView = null;
         ObjectUtils.disposeAllChildren(this);
         _controller = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _model.addEventListener("SELECTE_CHANGE",__tabSelectedHandler);
      }
      
      private function remveEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_model)
         {
            _model.removeEventListener("SELECTE_CHANGE",__tabSelectedHandler);
         }
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
      
      private function __tabSelectedHandler(param1:SortEvent) : void
      {
         switch(int(_model.currentSelected) - 12)
         {
            case 0:
               _rightView.visible = _mySortView.visible = false;
               _regressRightView.visible = true;
               break;
            default:
               _rightView.visible = _mySortView.visible = true;
               _regressRightView.visible = false;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         remveEvent();
         uninit();
         super.dispose();
         if(_isShowNumOne == false)
         {
            if(_model)
            {
               _model.cleanData();
               _model = null;
            }
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

