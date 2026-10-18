package map.campaign.mediator.fantasymatrix
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import map.campaign.CampaignManager;
   import map.campaign.data.FantasyMatrixModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   
   public class FantasyMatrixLeftView extends Component
   {
      
      private var leftBack:MutipleImage;
      
      private var curSocreText:FilterFrameText;
      
      private var scoreMc:MovieClip;
      
      private var boxVbox:VBox;
      
      private var boxList:Vector.<FantasyMatrixLeftBoxItem>;
      
      private var maxScore:int;
      
      private var rewardScoreArr:Array;
      
      public function FantasyMatrixLeftView()
      {
         super();
         resloveMaxScore();
         initView();
         initBoxListView();
         refreshView();
      }
      
      private function resloveMaxScore() : void
      {
         rewardScoreArr = ConfigInfoManager.instance.getFantasyMatrixScoreReward();
         var _loc1_:String = rewardScoreArr[rewardScoreArr.length - 1];
         maxScore = int(_loc1_.split(",")[0]);
      }
      
      private function initView() : void
      {
         leftBack = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixLeftView.leftBack");
         curSocreText = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixLeftView.curSocreText");
         scoreMc = ComponentFactory.Instance.creatCustomObject("FantasyMatrixLeftView.scoreMc");
         boxVbox = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixLeftView.boxVbox");
         addChild(leftBack);
         addChild(curSocreText);
         addChild(scoreMc);
         addChild(boxVbox);
      }
      
      private function initBoxListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FantasyMatrixLeftBoxItem = null;
         boxList = new Vector.<FantasyMatrixLeftBoxItem>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new FantasyMatrixLeftBoxItem();
            _loc1_.index = _loc2_;
            boxVbox.addChild(_loc1_);
            boxList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:FantasyMatrixLeftBoxItem = null;
         curSocreText.text = model.curScore + "";
         var _loc1_:int = int(model.curScore < maxScore ? int(model.curScore * 100 / maxScore) : 100);
         scoreMc.gotoAndStop(_loc1_);
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = boxList[_loc3_];
            _loc2_.refreshView();
            _loc3_++;
         }
      }
      
      private function get model() : FantasyMatrixModel
      {
         return CampaignManager.instance.fantasyMatrixModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(leftBack);
         leftBack = null;
         ObjectUtils.disposeObject(curSocreText);
         curSocreText = null;
         ObjectUtils.disposeViolentMc(scoreMc);
         scoreMc = null;
         ObjectUtils.disposeObject(boxVbox);
         boxVbox = null;
         LogicUtils.disposeDisplayCollection(boxList);
         super.dispose();
      }
   }
}

