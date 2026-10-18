package map.campaign.mediator.fantasymatrix
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import map.campaign.CampaignManager;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class FantasyMatrixLeftBoxItem extends Component
   {
      
      private var boxItem:BaseItemView;
      
      private var rewardScoreText:GradientText;
      
      private var isGetImage:Bitmap;
      
      private var fInfo:GoodsInfo;
      
      private var rewardScoreArr:Array;
      
      private var curScore:int;
      
      private var curCount:int;
      
      public function FantasyMatrixLeftBoxItem()
      {
         super();
         rewardScoreArr = ConfigInfoManager.instance.getFantasyMatrixScoreReward();
         fInfo = new GoodsInfo();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         boxItem = ComponentFactory.Instance.creatCustomObject("FantasyMatrixLeftBoxItem.boxItem");
         rewardScoreText = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixLeftBoxItem.rewardScoreText");
         isGetImage = ComponentFactory.Instance.creatBitmap("asset.FantasyMatrixLeftBoxItem.isGetImage");
         addChild(boxItem);
         addChild(rewardScoreText);
         addChild(isGetImage);
         isGetImage.visible = false;
      }
      
      public function set index(param1:int) : void
      {
         var _loc2_:String = rewardScoreArr[rewardScoreArr.length - param1 - 1];
         curScore = int(_loc2_.split(",")[0]);
         curCount = int(_loc2_.split(",")[1]);
      }
      
      public function refreshView() : void
      {
         fInfo.templateId = 2131515;
         fInfo.count = curCount;
         boxItem.data = fInfo;
         rewardScoreText.text = curScore + "";
         isGetImage.visible = CampaignManager.instance.fantasyMatrixModel.curScore >= curScore;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(boxItem);
         boxItem = null;
         ObjectUtils.disposeObject(rewardScoreText);
         rewardScoreText = null;
         ObjectUtils.disposeObject(isGetImage);
         isGetImage = null;
         super.dispose();
      }
   }
}

