package warsoultower
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.warsoultower.WarSoulTowerModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.WarSoulTowerStageTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.view.community.BaseItemView;
   
   public class WarSoulTowerStageItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _receiveTxt:FilterFrameText;
      
      private var _data:WarSoulTowerStageTempInfo;
      
      public function WarSoulTowerStageItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.warSoulTowerFrame.itemBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerStageItem.txt");
         _hBox = ComponentFactory.Instance.creatCustomObject("warSoulTowerStageItem.hBox");
         _receiveTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerStageItem.receiveTxt");
         addChild(_bg);
         addChild(_txt);
         addChild(_hBox);
         addChild(_receiveTxt);
      }
      
      public function set data(param1:WarSoulTowerStageTempInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _txt.text = LanguageMgr.GetTranslation("warSoulTowerStageItem.txt.text",_data.LevelId);
         creatRewardsView(_data.StageRewardItemId1,_data.StageRewardItemNum1);
         creatRewardsView(_data.StageRewardItemId2,_data.StageRewardItemNum2);
         creatRewardsView(_data.StageRewardItemId3,_data.StageRewardItemNum3);
         if(_data.LevelId <= model.highestLevel)
         {
            _receiveTxt.text = LanguageMgr.GetTranslation("warSoulTowerStageItem.receiveTxt.text1");
            _receiveTxt.y = 55;
            _receiveTxt.setFrame(1);
         }
         else
         {
            _receiveTxt.text = LanguageMgr.GetTranslation("warSoulTowerStageItem.receiveTxt.text2");
            _receiveTxt.y = 45;
            _receiveTxt.setFrame(2);
         }
      }
      
      private function creatRewardsView(param1:int, param2:int) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(_loc4_)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = param1;
            _loc5_.count = param2;
            _loc3_ = ComponentFactory.Instance.creatCustomObject("warSoulTowerStageItem.itemView");
            _loc3_.data = _loc5_;
            _hBox.addChild(_loc3_);
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
         ObjectUtils.disposeObject(_receiveTxt);
         _receiveTxt = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         super.dispose();
      }
   }
}

