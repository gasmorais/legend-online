package consortia.view.crossguild.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class RankIconRewardItem extends Component implements IManualSize
   {
      
      private var rewardItem:BaseItemView;
      
      private var rewardText:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      public function RankIconRewardItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,50,50);
      }
      
      private function initView() : void
      {
         rewardItem = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
         rewardText = ComponentFactory.Instance.creatComponentByStylename("RankIconRewardItem.rewardText");
         addChild(rewardItem);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc2_:Object = null;
         var _loc4_:Bitmap = null;
         var _loc3_:String = null;
         if(!param1)
         {
            return;
         }
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId);
         if(_loc5_)
         {
            rewardText.htmlText = "<font color=\'#ff8000\'><u>" + _loc5_.TemplateName + "</u>" + "*" + param1.count + "</font>";
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = param1.templateId;
            _loc6_.count = param1.count;
            rewardItem.data = _loc6_;
         }
         else
         {
            _loc2_ = {};
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.crossReward.item" + param1.templateId);
            _loc3_ = "";
            if(param1.templateId == 4)
            {
               _loc3_ = "(" + CrossGuildModel.RANK_TEMP4_DAYS[param1.blessValue] + LanguageMgr.GetTranslation("public.day") + ")";
            }
            _loc2_.itemName = LanguageMgr.GetTranslation("map.campaign.view.ui.gvgcross.reward.item" + param1.templateId) + _loc3_;
            _loc2_.des = LanguageMgr.GetTranslation("map.campaign.view.ui.gvgcross.reward.des" + param1.templateId);
            rewardItem.icon.icon = _loc4_;
            rewardItem.icon.tipStyle = "yishi.view.tips.goods.TmpTips";
            rewardItem.icon.tipData = _loc2_;
            rewardText.htmlText = "<font color=\'#ff8000\'><u>" + _loc2_.itemName + _loc3_ + "</u>" + "</font>";
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(rewardItem);
         rewardItem = null;
         ObjectUtils.disposeObject(rewardText);
         rewardText = null;
         super.dispose();
      }
   }
}

