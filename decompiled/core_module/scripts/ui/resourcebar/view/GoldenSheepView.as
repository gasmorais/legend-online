package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.GoldenSheepEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import mvc.module.goldensheep.GoldenSheepModel;
   import yishi.datas.VersionSwitch;
   import yishi.manager.GoldenSheepManager;
   
   public class GoldenSheepView extends Sprite implements Disposeable
   {
      
      private var _btn:BaseButton;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _model:GoldenSheepModel = GoldenSheepManager.instance.model;
      
      public function GoldenSheepView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("GoldenSheepView.btn");
         addChild(_btn);
         _effect = new MainToolBtnGlowEffect(_btn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
         _model.addEventListener("STATE_UPDATE",__stateUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__btnClickHandler);
         _model.removeEventListener("STATE_UPDATE",__stateUpdateHandler);
      }
      
      private function __stateUpdateHandler(param1:GoldenSheepEvent) : void
      {
         refreshView();
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         stopShine();
         GoldenSheepManager.instance.checkState();
      }
      
      private function shine() : void
      {
         if(_effect)
         {
            _effect.play();
         }
      }
      
      private function stopShine() : void
      {
         if(_effect)
         {
            _effect.stop();
         }
      }
      
      private function refreshView() : void
      {
         if(VersionSwitch.GOLDEN_SHEEP && _model.needShow)
         {
            _btn.visible = true;
         }
         else
         {
            _btn.visible = false;
         }
         if(_model.needShine)
         {
            shine();
         }
         else
         {
            stopShine();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

