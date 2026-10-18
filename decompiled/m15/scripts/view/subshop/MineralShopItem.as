package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.ShopManager;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class MineralShopItem extends Sprite implements Disposeable
   {
      
      private var _shine:Scale9CornerImage;
      
      private var _goods:BaseItemView;
      
      private var _name:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _image:Image;
      
      private var _input:Bitmap;
      
      private var _count:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _level:FilterFrameText;
      
      private var _line:Bitmap;
      
      private var _data:ShopGoodsInfo;
      
      public function MineralShopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _shine = ComponentFactory.Instance.creatComponentByStylename("MineralShopItem.shineBack");
         _goods = ComponentFactory.Instance.creatCustomObject("MineralShopItem.goods");
         _image = ComponentFactory.Instance.creatComponentByStylename("core.mineralsSmall");
         _name = ComponentFactory.Instance.creatComponentByStylename("MineralShopItem.name");
         _price = ComponentFactory.Instance.creatComponentByStylename("MineralShopItem.price");
         _input = ComponentFactory.Instance.creatBitmap("asset.shop.mineralsImput");
         _line = ComponentFactory.Instance.creatBitmap("asset.shop.mineralGap");
         _count = ComponentFactory.Instance.creatComponentByStylename("MineralShopItem.count");
         _level = ComponentFactory.Instance.creatComponentByStylename("MineralShopItem.level");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("MineralShopItem.buyBtn");
         addChild(_line);
         addChild(_shine);
         addChild(_goods);
         addChild(_image);
         addChild(_name);
         addChild(_price);
         addChild(_input);
         addChild(_count);
         addChild(_level);
         addChild(_buyBtn);
         _shine.alpha = 0;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-200);
         if(_loc1_)
         {
            _image.tipData = _loc1_.Description;
         }
      }
      
      private function addEvent() : void
      {
         _count.addEventListener("change",__inpunHandler);
         _buyBtn.addEventListener("click",__clickHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         if(_count)
         {
            _count.removeEventListener("change",__inpunHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__clickHandler);
         }
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_shine)
         {
            _shine.alpha = 1;
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         if(_shine)
         {
            _shine.alpha = 0;
         }
      }
      
      protected function __inpunHandler(param1:Event) : void
      {
         var _loc2_:int = int(_count.text);
         var _loc3_:int = Math.floor(playerInfo.mineral / _data.MineScore);
         _count.text = _loc2_ + "";
         if(_loc2_ <= 0 || _loc3_ <= 0)
         {
            _count.text = "1";
         }
         else if(_loc2_ >= _loc3_)
         {
            _count.text = _loc3_ + "";
         }
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:WildSoulInfo = null;
         var _loc3_:String = null;
         if(playerInfo.mineral < _data.MineScore)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.subshop.MineralShopItem.notEnough"));
            return;
         }
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
         if(_loc4_.SonType == 218)
         {
            _loc2_ = MountsManager.instance.avatarList.getWildSoulInfo(_loc4_.Property1);
            if(_loc2_ && _loc2_.validity < 0 && _loc4_.Property2 < 0)
            {
               _loc3_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
         }
         ShopManager.Instance.buyOne(_data.Id,int(_count.text),playerInfo.userId,_data.PayType,false);
         _count.text = "1";
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _data.ItemId;
         _goods.data = _loc3_;
         _name.htmlText = "<font color=\'#" + color(_loc3_) + " \'>" + _loc3_.templateInfo.TemplateName + "</font>";
         _name.numLines == 2 ? (_name.y = 9) : (Number(_name.y = 16));
         _price.text = _data.MineScore + "";
         _count.text = "1";
         setEnable();
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
         if(_loc2_.SonType == 218)
         {
            _count.type = "dynamic";
         }
         else
         {
            _count.type = "input";
         }
      }
      
      private function color(param1:GoodsInfo) : String
      {
         return param1.templateInfo.profileColor.toString(16);
      }
      
      private function setEnable() : void
      {
         if(_data.NeedMinGrade > thane.grades)
         {
            _level.text = LanguageMgr.GetTranslation("view.subshop.MineralShopItem.minLevel",_data.NeedMinGrade);
            _level.visible = true;
            _buyBtn.visible = false;
         }
         else
         {
            _level.visible = false;
            _buyBtn.visible = true;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_shine)
         {
            _shine.dispose();
         }
         _shine = null;
         if(_goods)
         {
            _goods.dispose();
         }
         _goods = null;
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
         if(_count)
         {
            _count.dispose();
         }
         _count = null;
         if(_buyBtn)
         {
            _buyBtn.dispose();
         }
         _buyBtn = null;
         if(_level)
         {
            _level.dispose();
         }
         _level = null;
         ObjectUtils.disposeObject(_image);
         _image = null;
         ObjectUtils.disposeObject(_input);
         _input = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

