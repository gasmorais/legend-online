package theseusCollention.UI
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollectionInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.utils.MsgMan;
   
   public class TheseusCollentionItemUI extends Sprite
   {
      
      private var _jindutiaoOriginWidth:Number = 0;
      
      private var _icon:Bitmap;
      
      private var _data:TheseusCollectionInfo;
      
      protected var _smallbg:ScaleFrameImage;
      
      protected var _theseusCollection_chip_pro_bg:Bitmap;
      
      protected var _jindutiao:ScaleFrameImage;
      
      protected var _nameTxt1:FilterFrameText;
      
      protected var _preTxt:FilterFrameText;
      
      protected var _starArr:Array = [];
      
      private var _starContaint:HBox;
      
      private var _url:String;
      
      private var _maskBar:Shape;
      
      protected var _red:Bitmap;
      
      protected var _type:int;
      
      public function TheseusCollentionItemUI(param1:int)
      {
         super();
         _type = param1;
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         _smallbg = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.smallItembg");
         _theseusCollection_chip_pro_bg = ComponentFactory.Instance.creatBitmap("theseusCollection_chip_pro_bg");
         _jindutiao = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.jindutiao");
         _nameTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.nameTxt1");
         _preTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.preTxt");
         _starContaint = ComponentFactory.Instance.creatComponentByStylename("ui.theseuscollection.StarHbox");
         _red = ComponentFactory.Instance.creatBitmap("asset.theseusCollection.red1");
         _jindutiaoOriginWidth = _jindutiao.width;
         addChild(_smallbg);
         addChild(_theseusCollection_chip_pro_bg);
         addChild(_jindutiao);
         addChild(_nameTxt1);
         addChild(_preTxt);
         addChild(_starContaint);
         if(_type == 1)
         {
            addChild(_red);
         }
         _maskBar = new Shape();
         _maskBar.x = _jindutiao.x;
         _maskBar.y = _jindutiao.y;
         addChild(_maskBar);
         _jindutiao.mask = _maskBar;
      }
      
      public function showPrecent(param1:Number, param2:Number) : void
      {
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc3_:Number = param1 / param2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         _maskBar.graphics.clear();
         _maskBar.graphics.beginFill(16711680);
         _maskBar.graphics.drawRect(0,0,_jindutiaoOriginWidth * _loc3_,_jindutiao.height);
         _maskBar.graphics.endFill();
      }
      
      private function initLoad() : void
      {
         if(_icon)
         {
            return;
         }
         LoaderManagerII.instance.load(_url,2,8,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 is Bitmap)
         {
            initView1(param2 as Bitmap);
         }
      }
      
      private function initView1(param1:Bitmap) : void
      {
         _icon = param1;
         _icon.y = 10;
         addChild(_icon);
         if(!_data.isPassive)
         {
            _icon.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("click",__equipBtnClickHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("click",__equipBtnClickHandler);
      }
      
      public function get data() : TheseusCollectionInfo
      {
         return _data;
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      public function set data(param1:TheseusCollectionInfo) : void
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return;
         }
         _data = param1;
         _url = PathManager.getcollectionPicPath(_data.templeteInfo.TemplateId + "");
         initLoad();
         _preTxt.text = "";
         _starContaint.visible = false;
         _smallbg.setFrame(_data.templeteInfo.Profile - 2);
         _nameTxt1.text = _data.templeteInfo.TemplateName;
         _nameTxt1.textColor = model.color[_data.templeteInfo.Profile - 3];
         _jindutiao.visible = false;
         _theseusCollection_chip_pro_bg.visible = false;
         _red.visible = model.checkRed(_data.templeteInfo.TemplateId);
         if(_data.isPassive)
         {
            if(_icon)
            {
               _icon.filters = null;
            }
            if(_data.star >= 0)
            {
               _starContaint.visible = true;
               showStar(_data.star,_starContaint);
            }
         }
         else
         {
            for each(var _loc3_:GoodsInfo in model.armorBagDic)
            {
               if(_loc3_.templateInfo.TemplateId == _data.starnextInfo.chipId)
               {
                  _loc2_ = int(_loc3_.count);
               }
            }
            if(_loc2_ <= 0)
            {
               _jindutiao.visible = false;
               _theseusCollection_chip_pro_bg.visible = false;
            }
            else
            {
               _jindutiao.setFrame(_data.templeteInfo.Profile - 2);
               _jindutiao.visible = true;
               showPrecent(_loc2_,_data.starnextInfo.chipNeedNum);
               _preTxt.text = setItemText(_loc2_) + "/" + _data.starnextInfo.chipNeedNum;
               _theseusCollection_chip_pro_bg.visible = true;
            }
         }
      }
      
      public function setItemText(param1:int) : String
      {
         var _loc2_:String = null;
         if(param1 == 0)
         {
            return "0";
         }
         var _loc3_:Number = param1 / 1000;
         if(param1 % 1000 == 0)
         {
            if(_loc3_ >= 1)
            {
               _loc2_ = int(_loc3_) + "k";
            }
         }
         else if(_loc3_ >= 1 && _loc3_ < 10)
         {
            _loc2_ = _loc3_.toFixed(1) + "k";
         }
         else if(_loc3_ > 10)
         {
            _loc2_ = int(_loc3_) + "k";
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
      
      private function showStar(param1:int, param2:HBox) : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = (param1 - 1) / 5 + 1;
         ObjectUtils.disposeAllChildren(param2);
         param2.beginChanges();
         var _loc5_:int = _loc7_ * 5;
         var _loc8_:int = (_loc7_ - 1) * 5;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc4_ = _loc8_ + _loc6_;
            if(param1 > _loc4_ && _loc7_ > 0)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("theseusCollection_staricon" + _loc7_);
               param2.addChild(_loc3_);
            }
            _loc6_++;
         }
         param2.commitChanges();
      }
      
      private function __equipBtnClickHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("TheseusCollentionItemUI",_data);
         model.selectData = _data.templeteInfo.TemplateId;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_smallbg);
         _smallbg = null;
         ObjectUtils.disposeObject(_theseusCollection_chip_pro_bg);
         _theseusCollection_chip_pro_bg = null;
         ObjectUtils.disposeObject(_jindutiao);
         _jindutiao = null;
         ObjectUtils.disposeObject(_nameTxt1);
         _nameTxt1 = null;
         ObjectUtils.disposeObject(_preTxt);
         _preTxt = null;
         _starArr = null;
         _url = null;
         ObjectUtils.disposeObject(_starContaint);
         _starContaint = null;
         ObjectUtils.disposeObject(_maskBar);
         _maskBar = null;
         ObjectUtils.disposeObject(_red);
         _red = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

