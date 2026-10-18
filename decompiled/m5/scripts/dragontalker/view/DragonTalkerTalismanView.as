package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerTalismanView extends Component
   {
      
      private var _intensifyBtn:SelectedIconButton;
      
      private var _swallowBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _swallowView:DragonTalkerSwallowView;
      
      private var _intensifyView:DragonTalkerIntensifyView;
      
      private var _bagView:DragonTalkerBagView;
      
      private var _leftBack:Image;
      
      public function DragonTalkerTalismanView()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         _leftBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj0u.leftBack");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanView.intensifyBtn");
         _swallowBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanView.swallowBtn");
         _bagView = ComponentFactory.Instance.creatCustomObject("DragonTalker.ppj0u.bagView");
         addChild(_leftBack);
         addChild(_intensifyBtn);
         addChild(_swallowBtn);
         addChild(_bagView);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_intensifyBtn);
         _btnGroup.addSelectItem(_swallowBtn);
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
         MsgMan.notifyObserver("TALISMAN_PAGE_CHANGE");
         switch(_btnGroup.getSelectedItem())
         {
            case _intensifyBtn:
               ObjectUtils.disposeObject(_swallowView);
               _swallowView = null;
               if(!_intensifyView)
               {
                  _intensifyView = ComponentFactory.Instance.creatCustomObject("DragonTalker.ppj0u.intensifyView");
               }
               addChild(_intensifyView);
               _bagView.viewType = 2;
               break;
            case _swallowBtn:
               ObjectUtils.disposeObject(_intensifyView);
               _intensifyView = null;
               if(!_swallowView)
               {
                  _swallowView = ComponentFactory.Instance.creatCustomObject("DragonTalker.ppj0u.swallowView");
               }
               addChild(_swallowView);
               _bagView.viewType = 3;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_swallowBtn);
         _swallowBtn = null;
         ObjectUtils.disposeObject(_swallowView);
         _swallowView = null;
         ObjectUtils.disposeObject(_intensifyView);
         _intensifyView = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_leftBack);
         _leftBack = null;
         _btnGroup.dispose();
         _btnGroup = null;
         super.dispose();
      }
   }
}

