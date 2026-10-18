package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.sumpassion.TaskMsg;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   
   public class SumCampaignTip extends BaseTip
   {
      
      private var _vBox:VBox;
      
      private var _nameTxt:FilterFrameText;
      
      private var _splitLine:ScaleBitmapImage;
      
      private var _rewardTxtTitle:FilterFrameText;
      
      private var _rewardBox:HBox;
      
      public function SumCampaignTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceNameVbox");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.SumCampaignNameText");
         _splitLine = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
         _rewardTxtTitle = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
         _rewardBox = new HBox();
         addChild(_vBox);
         _vBox.y = 10;
         _vBox.spacing = 6;
         _nameTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.SumCampaignTip.rewardNote");
      }
      
      override protected function updateTransform() : void
      {
         var _loc4_:int = 0;
         var _loc2_:GoodsInfo = null;
         var _loc3_:TaskTraceRewardItem = null;
         clean();
         _rewardBox.spacing = 3;
         _rewardBox.x = 5;
         var _loc1_:int = int((tipData as TaskMsg).item.length);
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = (tipData as TaskMsg).item[_loc4_].tempId;
            _loc2_.count = (tipData as TaskMsg).item[_loc4_].counts;
            _loc3_ = new TaskTraceRewardItem();
            _loc3_.data = _loc2_;
            _rewardBox.addChild(_loc3_);
            _loc4_++;
         }
         if(_rewardBox.numChildren > 0)
         {
            _vBox.addChild(_nameTxt);
            _vBox.addChild(_rewardTxtTitle);
            _rewardTxtTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardItem");
            _vBox.addChild(_splitLine);
            _vBox.addChild(_rewardBox);
         }
         _vBox.refreshChildPos();
         _bg.height = _vBox.height + _vBox.y + 4;
         _bg.width = 116;
         if(_nameTxt.textWidth >= _nameTxt.width)
         {
            _nameTxt.width = _nameTxt.textWidth + 2;
            _bg.width = _nameTxt.width + 10;
         }
         if(_splitLine)
         {
            _splitLine.width = 110;
         }
         if(_bg.width < _vBox.width)
         {
            _bg.width = _vBox.width + 10;
            if(_splitLine)
            {
               _splitLine.width = _bg.width - 3;
            }
         }
         if(_rewardBox && _rewardBox.numChildren == 1)
         {
            _rewardBox.x = int((_bg.width - _rewardBox.width) * 0.5);
         }
      }
      
      private function clean() : void
      {
         _vBox.removeAllChild();
         _rewardBox.disposeAllChildren();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeObject(_rewardTxtTitle);
         _rewardTxtTitle = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         super.dispose();
      }
   }
}

