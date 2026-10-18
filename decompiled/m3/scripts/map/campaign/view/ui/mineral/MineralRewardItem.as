package map.campaign.view.ui.mineral
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class MineralRewardItem extends Sprite implements Disposeable
   {
      
      private var _name:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _image:Bitmap;
      
      private var _data:ShopGoodsInfo;
      
      public function MineralRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _name = ComponentFactory.Instance.creatComponentByStylename("MineralRewardItem.name");
         _price = ComponentFactory.Instance.creatComponentByStylename("MineralRewardItem.price");
         _image = ComponentFactory.Instance.creatBitmap("asset.core.mineralsSmall");
         _level = ComponentFactory.Instance.creatComponentByStylename("MineralRewardItem.level");
         addChild(_name);
         addChild(_price);
         addChild(_level);
         addChild(_image);
         _image.x = 136;
         _image.y = 0;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.ItemId;
         _name.htmlText = "<font color=\'#" + color(_loc2_) + " \'>" + _loc2_.templateInfo.TemplateName + "</font>";
         _price.text = _data.MineScore + "";
         setEnable();
      }
      
      private function setEnable() : void
      {
         if(_data.NeedMinGrade > thane.grades)
         {
            _level.text = LanguageMgr.GetTranslation("view.subshop.MineralShopItem.minLevel",_data.NeedMinGrade);
            _level.visible = true;
            _price.visible = false;
            _image.visible = false;
         }
         else
         {
            _level.visible = false;
            _price.visible = true;
            _image.visible = true;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function color(param1:GoodsInfo) : String
      {
         return param1.templateInfo.profileColor.toString(16);
      }
      
      public function dispose() : void
      {
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_price)
         {
            _price.dispose();
         }
         _price = null;
         if(_level)
         {
            _level.dispose();
         }
         _level = null;
         ObjectUtils.disposeObject(_image);
         _image = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

