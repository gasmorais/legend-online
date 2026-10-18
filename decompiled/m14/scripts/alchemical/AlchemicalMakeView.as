package alchemical
{
   import alchemical.makeview.AlchemicalMakeBagView;
   import alchemical.makeview.AlchemicalMakeCooperationView;
   import alchemical.makeview.AlchemicalMakeMaterialView;
   import alchemical.makeview.AlchemicalMakeNoteBookView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.manager.AlchemicalManager;
   
   public class AlchemicalMakeView extends Component
   {
      
      private var back:MutipleImage;
      
      private var bagView:AlchemicalMakeBagView;
      
      private var materialView:AlchemicalMakeMaterialView;
      
      private var noteBookBtn:SelectedIconButton;
      
      private var cooperationBtn:SelectedIconButton;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var noteBookView:AlchemicalMakeNoteBookView;
      
      private var cooperationView:AlchemicalMakeCooperationView;
      
      public function AlchemicalMakeView()
      {
         super();
         initView();
         addEvent();
         model.selectFormulaInfo ? (btnGroup.selectIndex = 1) : (int(btnGroup.selectIndex = 0));
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeView.back");
         bagView = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeView.bagView",[2,13]);
         materialView = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeView.materialView");
         noteBookBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeView.noteBookBtn");
         cooperationBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeView.cooperationBtn");
         addChild(back);
         addChild(materialView);
         addChild(bagView);
         addChild(noteBookBtn);
         addChild(cooperationBtn);
         btnGroup = new SelectedButtonGroup();
         btnGroup.addSelectItem(noteBookBtn);
         btnGroup.addSelectItem(cooperationBtn);
      }
      
      private function addEvent() : void
      {
         btnGroup.addEventListener("change",__selectedChangHandler);
      }
      
      private function removeEvent() : void
      {
         btnGroup.removeEventListener("change",__selectedChangHandler);
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(btnGroup.selectIndex == 0)
         {
            ObjectUtils.disposeObject(cooperationView);
            cooperationView = null;
            if(!noteBookView)
            {
               noteBookView = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeView.noteBookView");
            }
            addChild(noteBookView);
         }
         else if(btnGroup.selectIndex == 1)
         {
            ObjectUtils.disposeObject(noteBookView);
            noteBookView = null;
            if(!cooperationView)
            {
               cooperationView = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeView.cooperationView");
            }
            addChild(cooperationView);
         }
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(materialView);
         materialView = null;
         ObjectUtils.disposeObject(bagView);
         bagView = null;
         ObjectUtils.disposeObject(noteBookBtn);
         noteBookBtn = null;
         ObjectUtils.disposeObject(cooperationBtn);
         cooperationBtn = null;
         ObjectUtils.disposeObject(noteBookView);
         noteBookView = null;
         ObjectUtils.disposeObject(cooperationView);
         cooperationView = null;
         model.selectFormulaInfo = null;
         super.dispose();
      }
   }
}

