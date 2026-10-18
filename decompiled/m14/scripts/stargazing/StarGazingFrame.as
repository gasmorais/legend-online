package stargazing
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.stargazing.StarGazingModel;
   import stargazing.view.StarChartView;
   import stargazing.view.StarForceView;
   import stargazing.view.StarWishView;
   import yishi.manager.StarGazingManager;
   
   public class StarGazingFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _starForceView:StarForceView;
      
      private var _starWishView:StarWishView;
      
      private var _starChartView:StarChartView;
      
      private var _starForceBtn:SelectedIconButton;
      
      private var _starChartBtn:SelectedIconButton;
      
      private var _starWishBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      public function StarGazingFrame()
      {
         super();
         initView();
         addEvent();
         StarGazingManager.instance.sendStarGazingRequest(0);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarGazingFrame.border");
         _starForceBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarGazingFrame.starForceBtn");
         _starChartBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarGazingFrame.starChartBtn");
         _starWishBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarGazingFrame.starWishBtn");
         addToContent(_border);
         addToContent(_starWishBtn);
         addToContent(_starChartBtn);
         addToContent(_starForceBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_starWishBtn);
         _btnGroup.addSelectItem(_starChartBtn);
         _btnGroup.addSelectItem(_starForceBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _starWishBtn:
               if(!_starWishView)
               {
                  _starWishView = ComponentFactory.Instance.creatCustomObject("StarGazing.StarGazingFrame.starWishView");
               }
               addToContent(_starWishView);
               _starWishView.refreshView();
               ObjectUtils.disposeObject(_starChartView);
               _starChartView = null;
               ObjectUtils.disposeObject(_starForceView);
               _starForceView = null;
               break;
            case _starChartBtn:
               if(!_starChartView)
               {
                  _starChartView = ComponentFactory.Instance.creatCustomObject("StarGazing.StarGazingFrame.starChartView");
               }
               addToContent(_starChartView);
               _starChartView.index = model.selectStarIndex;
               ObjectUtils.disposeObject(_starWishView);
               _starWishView = null;
               ObjectUtils.disposeObject(_starForceView);
               _starForceView = null;
               break;
            case _starForceBtn:
               if(!_starForceView)
               {
                  _starForceView = ComponentFactory.Instance.creatCustomObject("StarGazing.StarGazingFrame.starForceView");
               }
               addToContent(_starForceView);
               _starForceView.index = model.selectStarIndex;
               ObjectUtils.disposeObject(_starChartView);
               _starChartView = null;
               ObjectUtils.disposeObject(_starWishView);
               _starWishView = null;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("StarGazingFrame.title.text");
         if(param1 && param1.frameData)
         {
            _btnGroup.selectIndex = param1.frameData as int;
         }
         else
         {
            _btnGroup.selectIndex = 0;
         }
      }
      
      private function get model() : StarGazingModel
      {
         return StarGazingManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_starForceView);
         _starForceView = null;
         ObjectUtils.disposeObject(_starWishView);
         _starWishView = null;
         ObjectUtils.disposeObject(_starChartView);
         _starChartView = null;
         ObjectUtils.disposeObject(_starForceBtn);
         _starForceBtn = null;
         ObjectUtils.disposeObject(_starChartBtn);
         _starChartBtn = null;
         ObjectUtils.disposeObject(_starWishBtn);
         _starWishBtn = null;
         _btnGroup = null;
         super.dispose();
      }
   }
}

