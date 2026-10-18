package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.WarSoulTempInfo;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusCCItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _bgStyle:String;
      
      private const P_bgStyle:String = "bgStyle";
      
      private var _icon:BaseIconView;
      
      private var _iconStyle:String;
      
      private const P_iconStyle:String = "iconStyle";
      
      private var _isChoose:Boolean;
      
      private var _upFlg:Bitmap;
      
      private var _upFlgStyle:String;
      
      private const P_upFlgStyle:String = "upFlgStyle";
      
      private var _tipFlg:Bitmap;
      
      private var _tipFlgStyle:String;
      
      private const P_tipFlgStyle:String = "tipFlgStyle";
      
      private var _progressTxt:FilterFrameText;
      
      private var _progressStyle:String;
      
      private const P_progressStyle:String = "progressStyle";
      
      private var _profileImg:ScaleFrameImage;
      
      private var _profileStyle:String;
      
      private const P_profileStyle:String = "profileStyle";
      
      public var idx:int;
      
      private var _starContaint:HBox;
      
      private var _starConStyle:String;
      
      private const P_StarContaint:String = "starConStyle";
      
      private var _star:int = -1;
      
      private var _data:Object;
      
      private var _max:int;
      
      private var _curr:int;
      
      private var _chList:Array;
      
      public function TheseusCCItem()
      {
         super();
      }
      
      public function set starConStyle(param1:String) : void
      {
         _starConStyle = param1;
         onPropertiesChanged("starConStyle");
      }
      
      private function showStar(param1:int) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(param1 < 0)
         {
            return;
         }
         _star = param1;
         var _loc6_:int = (param1 - 1) / 5 + 1;
         ObjectUtils.disposeAllChildren(_starContaint);
         _starContaint.beginChanges();
         var _loc4_:int = _loc6_ * 5;
         var _loc7_:int = (_loc6_ - 1) * 5;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = _loc7_ + _loc5_;
            if(param1 > _loc3_ && _loc6_ > 0)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.core.profie.star" + _loc6_);
               _starContaint.addChild(_loc2_);
            }
            _loc5_++;
         }
         _starContaint.commitChanges();
      }
      
      public function set tipFlgStyle(param1:String) : void
      {
         _tipFlgStyle = param1;
         onPropertiesChanged("tipFlgStyle");
      }
      
      public function get isChoose() : Boolean
      {
         return _isChoose;
      }
      
      public function set isChoose(param1:Boolean) : void
      {
         _isChoose = param1;
         if(_upFlg)
         {
            _upFlg.visible = _isChoose;
         }
      }
      
      public function set profileStyle(param1:String) : void
      {
         _profileStyle = param1;
         onPropertiesChanged("profileStyle");
      }
      
      public function set progressStyle(param1:String) : void
      {
         _progressStyle = param1;
         onPropertiesChanged("progressStyle");
      }
      
      public function set upFlgStyle(param1:String) : void
      {
         _upFlgStyle = param1;
         onPropertiesChanged("upFlgStyle");
      }
      
      public function set iconStyle(param1:String) : void
      {
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function set bgStyle(param1:String) : void
      {
         _bgStyle = param1;
         onPropertiesChanged("bgStyle");
      }
      
      public function set star(param1:int) : void
      {
         if(_star == param1)
         {
            return;
         }
         _star = param1;
         if(_starContaint)
         {
            showStar(_star);
         }
      }
      
      public function get star() : int
      {
         return _star;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc3_:TheseusWarsoulItemInfo = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         if(_icon)
         {
            _data = param1;
            if(param1)
            {
               if(param1 is GoodsInfo)
               {
                  _loc4_ = param1 as GoodsInfo;
                  _icon.icon = IconFactory.getGoodsIconByTID(_loc4_.templateId);
                  if(_profileImg)
                  {
                     _profileImg.visible = true;
                     _profileImg.setFrame(_loc4_.templateInfo.Profile - 1);
                  }
                  _icon.tipData = param1;
               }
               else if(param1 is TheseusWarsoulItemInfo)
               {
                  _loc3_ = param1 as TheseusWarsoulItemInfo;
                  _icon.icon = IconFactory.getTheseusWarSoulIcon(_loc3_.warTempInfo.Icon);
                  if(_profileImg)
                  {
                     _profileImg.visible = true;
                     _profileImg.setFrame(_loc3_.warTempInfo.Profile - 1);
                  }
                  _icon.tipData = param1;
               }
               else if(param1 is WarSoulTempInfo)
               {
                  _icon.icon = IconFactory.getTheseusWarSoulIcon(param1.Icon);
                  _loc5_ = LanguageMgr.GetTranslation("theseus.war.starMM",_star,(param1 as WarSoulTempInfo).Name);
                  _loc2_ = GoodsHelp.getGoodColorString(param1.Profile);
                  _icon.tipData = AttributeUtils.getColorStr(_loc5_,_loc2_,false);
                  if(_profileImg)
                  {
                     _profileImg.visible = true;
                     _profileImg.setFrame(param1.Profile - 1);
                  }
               }
            }
            else
            {
               _icon.icon = null;
               _icon.tipData = null;
               if(_profileImg)
               {
                  _profileImg.visible = false;
               }
               isChoose = false;
            }
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get isEnougth() : Boolean
      {
         return _curr >= _max && _curr > 0;
      }
      
      public function updateProgess(param1:int, param2:int) : void
      {
         if(_progressTxt)
         {
            _max = param2;
            _curr = param1;
            _progressTxt.text = param1 + "/" + param2;
            if(param1 >= param2)
            {
               if(_upFlg)
               {
                  _upFlg.visible = false;
               }
               _progressTxt.setFrame(1);
            }
            else
            {
               if(_upFlg)
               {
                  _upFlg.visible = true;
               }
               _progressTxt.setFrame(2);
            }
            _progressTxt.height = _progressTxt.numLines * 20;
            if(_progressTxt.numLines > 1)
            {
               _progressTxt.htmlText = param1 + "\n" + "/" + param2;
               _progressTxt.y = 42;
            }
            else
            {
               _progressTxt.y = 57;
            }
         }
      }
      
      public function hideTipFlg() : void
      {
         if(_tipFlg)
         {
            _tipFlg.visible = false;
         }
      }
      
      public function showTipFlg() : void
      {
         if(_tipFlg && _chList && _chList.length >= _max)
         {
            _tipFlg.visible = true;
         }
      }
      
      public function set chList(param1:Array) : void
      {
         _chList = param1;
         if(_tipFlg && _chList && _chList.length >= _max)
         {
            _tipFlg.visible = true;
         }
         else
         {
            _tipFlg.visible = false;
         }
      }
      
      public function get chList() : Array
      {
         return _chList;
      }
      
      public function updateProgValue(param1:String) : void
      {
         if(_progressTxt)
         {
            _progressTxt.text = param1;
         }
      }
      
      public function get max() : int
      {
         return _max;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["bgStyle"])
         {
            _bg = ComponentFactory.Instance.creatBitmap(_bgStyle);
         }
         if(_changedPropeties["iconStyle"])
         {
            _icon = ComponentFactory.Instance.creatCustomObject(_iconStyle);
         }
         if(_changedPropeties["upFlgStyle"])
         {
            _upFlg = ComponentFactory.Instance.creatBitmap(_upFlgStyle);
         }
         if(_changedPropeties["progressStyle"])
         {
            _progressTxt = ComponentFactory.Instance.creatComponentByStylename(_progressStyle);
         }
         if(_changedPropeties["profileStyle"])
         {
            _profileImg = ComponentFactory.Instance.creatComponentByStylename(_profileStyle);
            _profileImg.visible = false;
         }
         if(_changedPropeties["tipFlgStyle"])
         {
            _tipFlg = ComponentFactory.Instance.creatBitmap(_tipFlgStyle);
            _tipFlg.visible = false;
         }
         if(_changedPropeties["starConStyle"])
         {
            _starContaint = ComponentFactory.Instance.creatComponentByStylename(_starConStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_upFlg)
         {
            addChild(_upFlg);
         }
         if(_profileImg)
         {
            addChild(_profileImg);
         }
         if(_starContaint)
         {
            addChild(_starContaint);
         }
         if(_progressTxt)
         {
            addChild(_progressTxt);
         }
         if(_tipFlg)
         {
            addChild(_tipFlg);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_upFlg);
         _upFlg = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_tipFlg);
         _tipFlg = null;
         ObjectUtils.disposeObject(_starContaint);
         _starContaint = null;
         super.dispose();
         _data = null;
      }
   }
}

