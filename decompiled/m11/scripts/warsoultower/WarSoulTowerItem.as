package warsoultower
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.warsoultower.WarSoulTowerModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.WarSoulTowerLevelTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.view.community.BaseItemView;
   
   public class WarSoulTowerItem extends Component
   {
      
      private var _levelTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _data:WarSoulTowerLevelTempInfo;
      
      private var _type:int;
      
      public function WarSoulTowerItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerItem.levelTxt");
         _hBox = ComponentFactory.Instance.creatCustomObject("warSoulTowerItem.hBox");
         addChild(_levelTxt);
         addChild(_hBox);
      }
      
      public function set data(param1:WarSoulTowerLevelTempInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _levelTxt.text = LanguageMgr.GetTranslation("warSoulTowerItem.levelTxt.text",_data.LevelId);
         _hBox.removeAllChild();
         if(_type == 1)
         {
            creatRewardsView(_data.FirstRewardItemId1,_data.FirstRewardItemNum1);
            creatRewardsView(_data.FirstRewardItemId2,_data.FirstRewardItemNum2);
            creatRewardsView(_data.FirstRewardItemId3,_data.FirstRewardItemNum3);
         }
         else if(_type == 2)
         {
            creatRewardsView(_data.RepeatRewardItemId1,_data.RepeatRewardItemNum1);
            creatRewardsView(_data.RepeatRewardItemId2,_data.RepeatRewardItemNum2);
            creatRewardsView(_data.RepeatRewardItemId3,_data.RepeatRewardItemNum3);
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
            _loc3_ = ComponentFactory.Instance.creatCustomObject("warSoulTowerItem.itemView");
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
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         super.dispose();
      }
   }
}

