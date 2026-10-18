package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.petchallenge.PetChallengeModel;
   import yishi.datas.templates.cate.PetChallengeRewardTemplate;
   import yishi.manager.TempleteManager;
   
   public class PetChallengeWeekRewardTipView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _alertText:FilterFrameText;
      
      private var _kingRewardAlert:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _vScrollPanel:ScrollPanel;
      
      public function PetChallengeWeekRewardTipView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("PetChallengeWeekRewardTipView.vbox");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeWeekRewardTipView.alertText");
         _kingRewardAlert = ComponentFactory.Instance.creatComponentByStylename("PetChallengeWeekRewardTipView.kingRewardAlert");
         _bg.width = 620;
         _bg.height = 325;
         addChild(_bg);
         _vScrollPanel = ComponentFactory.Instance.creatComponentByStylename("petchallengeWeek.bagScrollPanel");
         addChild(_vScrollPanel);
         _vScrollPanel.width = 620;
         _vScrollPanel.x = 10;
         _vScrollPanel.y = 5;
         _vScrollPanel.setView(_vBox);
         _vScrollPanel.vScrollbar.visible = false;
         _alertText.text = LanguageMgr.GetTranslation("PetChallengeWeekRewardTipView.alertText.text");
         _kingRewardAlert.text = LanguageMgr.GetTranslation("PetChallengeWeekRewardTipView.kingRewardAlert.text");
         _vBox.addChild(_alertText);
         _vBox.addChild(_kingRewardAlert);
         var _loc1_:Array = TempleteManager.instance.petChallengeRewardCate.getRewardsByGroup(2);
         refreshView(_loc1_,2);
         _loc1_ = TempleteManager.instance.petChallengeRewardCate.getRewardsByGroup(3);
         refreshView(_loc1_,3);
         _loc1_ = TempleteManager.instance.petChallengeRewardCate.getRewardsByGroup(4);
         refreshView(_loc1_,4);
         _loc1_ = TempleteManager.instance.petChallengeRewardCate.getRewardsByGroup(5);
         refreshView(_loc1_,5);
         _loc1_ = TempleteManager.instance.petChallengeRewardCate.getRewardsByGroup(6);
         refreshView(_loc1_,6);
         _loc1_ = null;
      }
      
      private function refreshView(param1:Array, param2:int) : void
      {
         var _loc11_:int = 0;
         var _loc4_:String = null;
         var _loc5_:FilterFrameText = null;
         var _loc8_:FilterFrameText = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc7_:HBox = null;
         var _loc12_:Dictionary = new Dictionary(true);
         var _loc13_:Array = [];
         var _loc6_:String = LanguageMgr.GetTranslation("petchallenge.views.PetChallengeInfoView.group" + param2);
         for each(var _loc3_:PetChallengeRewardTemplate in param1)
         {
            if(_loc3_.min != _loc3_.max)
            {
               _loc11_ = int(_loc3_.min);
               if(!_loc12_[_loc11_])
               {
                  _loc12_[_loc11_] = [];
                  _loc13_.push(_loc11_);
               }
               _loc12_[_loc11_].ranking = _loc3_.Ranking.split("|")[1].replace(",","-");
               _loc12_[_loc11_].push(_loc3_.rewardName);
            }
         }
         _loc13_.sort(16);
         for each(_loc11_ in _loc13_)
         {
            _loc4_ = model.groupScoreArr[param2 - 2];
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("PetChallengeWeekRewardTipView.titleTxt");
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("PetChallengeWeekRewardTipView.rewardTxt");
            _loc9_ = _loc12_[_loc11_].ranking as String;
            _loc10_ = _loc9_.split("-");
            if(_loc10_.length == 2)
            {
               if(int(_loc10_[1]) >= 1000000)
               {
                  _loc9_ = LanguageMgr.GetTranslation("PetChallengeWeekRewardTipView.outOfRank",int(_loc10_[0]) - 1);
               }
               else if(int(_loc10_[0]) <= 2)
               {
                  _loc9_ = LanguageMgr.GetTranslation("PetChallengeWeekRewardTipView.innerOfRank",_loc10_[1]);
               }
            }
            _loc5_.htmlText = LanguageMgr.GetTranslation("PetChallengeWeekRewardTipView.week4",_loc6_,_loc4_,_loc9_);
            _loc8_.htmlText = _loc12_[_loc11_].join("\n");
            _loc7_ = new HBox();
            _loc7_.addChild(_loc5_);
            _loc7_.addChild(_loc8_);
            _vBox.addChild(_loc7_);
            if(_vBox.displayHeight > 320)
            {
               _vScrollPanel.vScrollbar.visible = true;
               _vScrollPanel.invalidateViewport();
            }
         }
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_kingRewardAlert);
         _kingRewardAlert = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_vScrollPanel);
         _vScrollPanel = null;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
      }
   }
}

