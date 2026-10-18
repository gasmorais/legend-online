package areslords.reward
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class AresLordsRewardItemView extends Component implements IListCell
   {
      
      private var _medal:ScaleFrameImage;
      
      private var _groupName:ScaleFrameImage;
      
      private var _rewardCoin:Image;
      
      private var _rewardNumTxt:FilterFrameText;
      
      private var _split:Image;
      
      public function AresLordsRewardItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _medal = ComponentFactory.Instance.creatComponentByStylename("areslords.RewardMedal");
         _groupName = ComponentFactory.Instance.creatComponentByStylename("areslords.RewardGroupName");
         _rewardCoin = ComponentFactory.Instance.creatComponentByStylename("areslords.RewardCoin");
         _rewardNumTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.RewardNumTxt");
         _split = ComponentFactory.Instance.creatComponentByStylename("areslords.RewardSplit");
         addChild(_medal);
         addChild(_groupName);
         addChild(_rewardCoin);
         addChild(_rewardNumTxt);
         addChild(_split);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_medal);
         _medal = null;
         ObjectUtils.disposeObject(_groupName);
         _groupName = null;
         ObjectUtils.disposeObject(_rewardCoin);
         _rewardCoin = null;
         ObjectUtils.disposeObject(_rewardNumTxt);
         _rewardNumTxt = null;
         ObjectUtils.disposeObject(_split);
         _split = null;
         super.dispose();
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return null;
      }
      
      public function setCellValue(param1:*) : void
      {
         if(param1)
         {
            _medal.visible = true;
            _groupName.visible = true;
            _rewardCoin.visible = true;
            _medal.setFrame(param1.index);
            _groupName.setFrame(param1.index);
            if(param1.index == 1)
            {
               _groupName.x = 22;
            }
            _rewardNumTxt.text = param1.num + "";
         }
         else
         {
            _medal.visible = false;
            _groupName.visible = false;
            _rewardCoin.visible = false;
            _rewardNumTxt.text = "";
         }
      }
   }
}

