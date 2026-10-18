package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PetEquipIcon extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _item:BaseItemView;
      
      private var _equipName:FilterFrameText;
      
      private var _openCondition:FilterFrameText;
      
      private var _lockImg:Bitmap;
      
      private var _data:GoodsInfo;
      
      private var _openState:Boolean = true;
      
      public function PetEquipIcon()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.tips.equipGemBg");
         _item = ComponentFactory.Instance.creatCustomObject("tips.PetEquipItemView");
         _equipName = ComponentFactory.Instance.creatComponentByStylename("tips.petEquipIcon.equipNameTxt");
         _openCondition = ComponentFactory.Instance.creatComponentByStylename("tip.petEquipIcon.openConditionTxt");
         _lockImg = ComponentFactory.Instance.creatBitmap("asset.tips.equipHoldClosed02");
         addChild(_bg);
         _bg.width = 41;
         _bg.height = 41;
         _bg.x = 23;
         addChild(_item);
         addChild(_equipName);
         addChild(_openCondition);
         _openCondition.text = LanguageMgr.GetTranslation("yishi.view.tips.PetEquipIcon.openCondition");
         addChild(_lockImg);
         _lockImg.x = 34;
         _lockImg.y = 7;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         if(!param1)
         {
            _item.data = null;
            _equipName.text = LanguageMgr.GetTranslation("yishi.view.tips.PetEquipIcon.notEquip");
            _equipName.setFrame(6);
            return;
         }
         _openCondition.visible = false;
         _lockImg.visible = false;
         _data = param1;
         _item.data = _data;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
         _equipName.text = _loc2_.TemplateName;
         _equipName.setFrame(_loc2_.Profile);
      }
      
      public function set openState(param1:Boolean) : void
      {
         _openState = param1;
         if(!_openState)
         {
            _lockImg.visible = false;
            if(_openCondition && !_openCondition.parent)
            {
               addChild(_openCondition);
            }
            _openCondition.visible = true;
            _equipName.visible = false;
            _item.visible = false;
         }
         else
         {
            if(_openCondition && _openCondition.parent)
            {
               _openCondition.parent.removeChild(_openCondition);
            }
            _lockImg.visible = false;
            _equipName.visible = true;
            _item.visible = true;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_equipName);
         _equipName = null;
         ObjectUtils.disposeObject(_openCondition);
         _openCondition = null;
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_lockImg);
      }
   }
}

