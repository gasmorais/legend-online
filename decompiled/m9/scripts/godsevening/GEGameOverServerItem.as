package godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GEGameOverServerItem extends Component
   {
      
      public static const REWARD_TEMPLATE_ID:int = -11000;
      
      private var _bg:ScaleFrameImage;
      
      private var _rankImg:ScaleFrameImage;
      
      private var _serverName:FilterFrameText;
      
      private var _rewardIcon:BaseIconView;
      
      private var _rewardCount:FilterFrameText;
      
      private var _rank:int;
      
      public function GEGameOverServerItem(param1:int)
      {
         _rank = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("GEGameOverServerItem.Bg");
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("GEGameOverServerItem.RankNum");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("GEGameOverServerItem.ServerName");
         _rewardIcon = ComponentFactory.Instance.creatCustomObject("GEGameOverServerItem.RewardIcon");
         _rewardCount = ComponentFactory.Instance.creatComponentByStylename("GEGameOverServerItem.RewardCount");
         addChild(_bg);
         addChild(_rankImg);
         _rankImg.visible = false;
         addChild(_serverName);
         addChild(_rewardIcon);
         addChild(_rewardCount);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankImg);
         _rankImg = null;
         ObjectUtils.disposeObject(_serverName);
         _serverName = null;
         ObjectUtils.disposeObject(_rewardIcon);
         _rewardIcon = null;
         ObjectUtils.disposeObject(_rewardCount);
         _rewardCount = null;
      }
      
      override public function dispose() : void
      {
         unInitView();
         super.dispose();
      }
      
      public function setData(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = -11000;
         _bg.setFrame(param3);
         _rankImg.setFrame(_rank);
         _rankImg.visible = true;
         _serverName.text = param1;
         _rewardIcon.icon = IconFactory.getGoodsIconByTID(-11000);
         _rewardIcon.tipData = _loc4_;
         _rewardCount.text = LanguageMgr.GetTranslation("godsEvening.GEGameOverServerItem.rewardCount",param2);
      }
   }
}

