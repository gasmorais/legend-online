package warsoultower
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.warsoultower.WarSoulTowerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.StringHelper;
   
   public class WarSoulTowerResultItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _type:int;
      
      public function WarSoulTowerResultItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.warSoulTowerFrame.itemBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultItem.txt");
         _vBox = ComponentFactory.Instance.creatCustomObject("warSoulTowerResultItem.vBox");
         addChild(_bg);
         addChild(_txt);
         addChild(_vBox);
         _bg.width = 282;
      }
      
      public function set data(param1:*) : void
      {
         if(!param1)
         {
            return;
         }
         _vBox.removeAllChild();
         if(_type == 0)
         {
            creatRewardsView(param1.RepeatRewardItemId1,param1.RepeatRewardItemNum1);
            creatRewardsView(param1.RepeatRewardItemId2,param1.RepeatRewardItemNum2);
            creatRewardsView(param1.RepeatRewardItemId3,param1.RepeatRewardItemNum3);
         }
         else if(_type == 1)
         {
            creatRewardsView(param1.FirstRewardItemId1,param1.FirstRewardItemNum1);
            creatRewardsView(param1.FirstRewardItemId2,param1.FirstRewardItemNum2);
            creatRewardsView(param1.FirstRewardItemId3,param1.FirstRewardItemNum3);
         }
         else if(_type == 2)
         {
            creatRewardsView(param1.StageRewardItemId1,param1.StageRewardItemNum1);
            creatRewardsView(param1.StageRewardItemId2,param1.StageRewardItemNum2);
            creatRewardsView(param1.StageRewardItemId3,param1.StageRewardItemNum3);
         }
         _txt.text = LanguageMgr.GetTranslation("warSoulTowerResultItem.txt.text" + _type,param1.LevelId);
      }
      
      private function creatRewardsView(param1:int, param2:int) : void
      {
         var _loc4_:FilterFrameText = null;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(_loc3_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultItem.goodsTxt");
            _loc4_.htmlText = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_loc3_.Profile),_loc3_.TemplateName);
            _loc4_.htmlText += "x" + param2;
            _loc4_.height = 20 * _loc4_.numLines;
            _vBox.addChild(_loc4_);
         }
      }
      
      private function get model() : WarSoulTowerModel
      {
         return WarSoulTowerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}

