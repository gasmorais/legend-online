package timevortex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import managers.TimeVortexManager;
   import mvc.module.timevortex.TimeVortexDropTemplateInfo;
   import mvc.module.timevortex.TimeVortexModel;
   
   public class TimeVortexCrackDefendRewardView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleBg:Image;
      
      private var _titleImg:Image;
      
      private var _rewardView:TimeVortexCrackRewardView;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      public function TimeVortexCrackDefendRewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackDefendRewardView.bg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackDefendRewardView.titleBg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackDefendRewardView.titleImg");
         _rewardView = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexCrackDefendRewardView.rewardView");
         addChild(_bg);
         addChild(_titleBg);
         addChild(_titleImg);
         addChild(_rewardView);
         initRewards();
      }
      
      private function initRewards() : void
      {
         var _loc1_:Dictionary = _model.getDropInfos(_model.selectedChapter.chapterId);
         if(_loc1_)
         {
            _rewardView.dropInfos = _loc1_[6] as Vector.<TimeVortexDropTemplateInfo>;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         dispatchEvent(new Event("dispose"));
      }
   }
}

