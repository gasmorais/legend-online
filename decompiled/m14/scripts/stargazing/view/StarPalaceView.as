package stargazing.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import mvc.module.stargazing.StarGazingModel;
   import yishi.manager.StarGazingManager;
   
   public class StarPalaceView extends Component
   {
      
      public static const STAR_NUM:int = 12;
      
      private var _vbox:VBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      public function StarPalaceView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SelectedIconButton = null;
         _vbox = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarPalaceView.vbox");
         addChild(_vbox);
         _btnGroup = new SelectedButtonGroup();
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("StarPalaceView.starBtn" + _loc2_);
            _vbox.addChild(_loc1_);
            _btnGroup.addSelectItem(_loc1_);
            _loc2_++;
         }
         _btnGroup.selectIndex = model.selectStarIndex;
      }
      
      private function addEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         model.selectStarIndex = _btnGroup.selectIndex;
      }
      
      public function get btnGroup() : SelectedButtonGroup
      {
         return _btnGroup;
      }
      
      private function get model() : StarGazingModel
      {
         return StarGazingManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         super.dispose();
      }
   }
}

