package map.campaign.mediator.mapview
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import managers.TaskTraceTipManager;
   import map.campaign.view.ui.secretland.ConsortiaSecretInfoView;
   import map.campaign.view.ui.secretland.ConsortiaSecretTimeView;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.interfaces.IMediator;
   import yishi.manager.ConsortiaManager;
   
   public class ConsortiaSecretMapMediator implements IMediator
   {
      
      private var _secretInfoView:ConsortiaSecretInfoView;
      
      private var _secretTimeView:ConsortiaSecretTimeView;
      
      private var _secretSortView:ConsortiaSecretSortView;
      
      private var _flexBtn:BaseButton;
      
      private var _arrow:Bitmap;
      
      public function ConsortiaSecretMapMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         initView();
         addEvent();
         TaskTraceTipManager.instance.cleanByType(25);
      }
      
      private function initView() : void
      {
         _secretInfoView = new ConsortiaSecretInfoView();
         _secretInfoView.setData(model.secretInfo);
         _secretInfoView.y = 200;
         _secretInfoView.show();
         if(model.secretInfo.secretState != 0)
         {
            resetShowView();
         }
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         if(_secretInfoView)
         {
            ObjectUtils.disposeObject(_secretInfoView);
         }
         _secretInfoView = null;
         if(_secretTimeView)
         {
            ObjectUtils.disposeObject(_secretTimeView);
         }
         _secretTimeView = null;
         if(_secretSortView)
         {
            ObjectUtils.disposeObject(_secretSortView);
         }
         _secretSortView = null;
         ObjectUtils.disposeObject(_flexBtn);
         _flexBtn = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
      }
      
      private function addEvent() : void
      {
         model.secretInfo.addEventListener("SECRET_UPDATE",__secretUpdateHandler);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function removeEvent() : void
      {
         model.secretInfo.removeEventListener("SECRET_UPDATE",__secretUpdateHandler);
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_flexBtn)
         {
            _flexBtn.removeEventListener("click",__flexClickHandler);
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_secretSortView)
         {
            _secretSortView.x = StageReferance.stageWidth - 240;
         }
         if(_secretTimeView)
         {
            _secretTimeView.x = (StageReferance.stageWidth - 220) / 2;
            _secretTimeView.y = StageReferance.stageHeight - 150;
         }
         if(_flexBtn && _secretSortView)
         {
            _flexBtn.x = _secretSortView.x - 28;
         }
      }
      
      private function __secretUpdateHandler(param1:ConsortiaEvent) : void
      {
         if(_secretInfoView)
         {
            _secretInfoView.refreshView();
         }
         if(model.secretInfo.secretState != 0)
         {
            resetShowView();
         }
         else
         {
            ObjectUtils.disposeObject(_secretTimeView);
            _secretTimeView = null;
            ObjectUtils.disposeObject(_secretSortView);
            _secretSortView = null;
            ObjectUtils.disposeObject(_flexBtn);
            _flexBtn = null;
            ObjectUtils.disposeObject(_arrow);
            _arrow = null;
         }
      }
      
      private function resetShowView() : void
      {
         if(_flexBtn)
         {
            _flexBtn.removeEventListener("click",__flexClickHandler);
         }
         if(!_secretTimeView)
         {
            _secretTimeView = new ConsortiaSecretTimeView();
         }
         _secretTimeView.setData(model.secretInfo);
         _secretTimeView.x = (StageReferance.stageWidth - 220) / 2;
         _secretTimeView.y = StageReferance.stageHeight - 150;
         _secretTimeView.show();
         if(!_secretSortView)
         {
            _secretSortView = new ConsortiaSecretSortView();
         }
         _secretSortView.x = StageReferance.stageWidth - 240;
         _secretSortView.y = 200;
         _secretSortView.show();
         if(!_flexBtn)
         {
            _flexBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretMapMediator.flexBtn");
         }
         if(!_arrow)
         {
            _arrow = ComponentFactory.Instance.creatBitmap("asset.ConsortiaSecretMapMediator.arrow");
         }
         LayerManager.Instance.addToLayer(_flexBtn,4,false,false);
         _flexBtn.addEventListener("click",__flexClickHandler);
         _flexBtn.addChild(_arrow);
         if(_secretSortView.showState)
         {
            _flexBtn.x = StageReferance.stageWidth - 268;
         }
         else
         {
            _flexBtn.x = StageReferance.stageWidth - 28;
         }
      }
      
      private function __flexClickHandler(param1:MouseEvent) : void
      {
         _secretSortView.showState = !_secretSortView.showState;
         if(_secretSortView.showState)
         {
            _arrow.scaleX = 1;
            _arrow.x = 5;
            TweenMax.killTweensOf(_flexBtn);
            TweenMax.to(_flexBtn,0.5,{"x":StageReferance.stageWidth - 268});
         }
         else
         {
            _arrow.scaleX = -1;
            _arrow.x = 24;
            TweenMax.killTweensOf(_flexBtn);
            TweenMax.to(_flexBtn,0.5,{"x":StageReferance.stageWidth - 28});
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
   }
}

