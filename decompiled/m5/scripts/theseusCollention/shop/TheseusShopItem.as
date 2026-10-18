package theseusCollention.shop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   
   public class TheseusShopItem extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _selectBg:ScaleFrameImage;
      
      private var _data:GoodsInfo;
      
      private var _title:GradientText;
      
      private var _num:FilterFrameText;
      
      private var _limlt:FilterFrameText;
      
      private var _money:FilterFrameText;
      
      private var _moneybg:Bitmap;
      
      private var _moneyicon:Bitmap;
      
      public function TheseusShopItem(param1:int)
      {
         super();
         _id = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("theseusbox.icon");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("theseusCollection_shopitemselect");
         _title = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameTxt11");
         _back.setFrame(_id + 1);
         _selectBg.setFrame(_id + 1);
         _num = ComponentFactory.Instance.creatComponentByStylename("theseuscollectionBox.view.num");
         _moneyicon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _moneybg = ComponentFactory.Instance.creatBitmap("theseusCollection_shopnumbg");
         _money = ComponentFactory.Instance.creatComponentByStylename("theseuscollectionshopBox.view.moneynum");
         _limlt = ComponentFactory.Instance.creatComponentByStylename("theseuscollectionshopBox.view.limitnum");
         _moneybg.x = -15;
         _moneybg.y = 100;
         addChild(_selectBg);
         addChild(_back);
         addChild(_title);
         addChild(_moneybg);
         addChild(_moneyicon);
         _moneyicon.x = 70;
         _moneyicon.y = 100;
         addChild(_money);
         addChild(_limlt);
         addChild(_num);
         _selectBg.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         model.selectshopBox = data;
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc3_:ShopGoodsInfo = null;
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(data)
         {
            for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getthessShopTemplateDic())
            {
               if(_loc2_.template.TemplateId == param1.templateId)
               {
                  _loc3_ = _loc2_;
               }
            }
            _title.text = data.templateInfo.TemplateName;
            _selectBg.visible = data.templateInfo.TemplateId == model.selectshopBox.templateInfo.TemplateId;
            _num.text = data.count + "";
            if(_loc3_.VIP0Count < 0)
            {
               _limlt.text = LanguageMgr.GetTranslation("theseuscollectbox.txt4");
            }
            else
            {
               _limlt.text = LanguageMgr.GetTranslation("theseuscollectbox.txt3") + _loc3_.canOneCount + "/" + _loc3_.VIP0Count;
            }
            _money.text = _loc3_.Point + "";
         }
      }
      
      public function set select(param1:Boolean) : void
      {
         _selectBg.visible = param1;
      }
      
      public function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_num);
         _num = null;
         _data = null;
         super.dispose();
      }
   }
}

