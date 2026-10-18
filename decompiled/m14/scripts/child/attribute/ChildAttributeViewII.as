package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   
   public class ChildAttributeViewII extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _data:ChildData;
      
      private var _vBox3:VBox;
      
      private var _vBox4:VBox;
      
      private var _vBox5:VBox;
      
      private var _vBox6:VBox;
      
      private var _attNameList:Array;
      
      private var _txtList:Vector.<FilterFrameText>;
      
      private var _delay:uint;
      
      private var _withAttri:CustomBitmap;
      
      private var _withAttriLine:CustomBitmap;
      
      public function ChildAttributeViewII()
      {
         super();
         initData();
         initView();
      }
      
      private function initData() : void
      {
         _attNameList = ["Emblem1","Emblem2","Emblem3","Emblem4","Emblem5","Emblem6","Emblem7","Emblem8","Emblem9","Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.bg");
         _vBox3 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox3");
         _vBox4 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox4");
         _vBox5 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox5");
         _vBox6 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox6");
         _withAttri = ComponentFactory.Instance.creatCustomObject("ChildAttributeViewII.withAttriImg");
         _withAttriLine = ComponentFactory.Instance.creatCustomObject("ChildAttributeViewII.withAttriLineImg");
         _txtList = new Vector.<FilterFrameText>();
         addChild(_bg);
         addChild(_vBox3);
         addChild(_vBox4);
         addChild(_vBox5);
         addChild(_vBox6);
         addChild(_withAttri);
         addChild(_withAttriLine);
         addImageAndTxt();
      }
      
      private function addImageAndTxt() : void
      {
         var _loc2_:Bitmap = null;
         var _loc1_:FilterFrameText = null;
         var _loc3_:FilterFrameText = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _attNameList.length)
         {
            if(_loc4_ < 9)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.nameTxt");
               _loc3_.text = LanguageMgr.GetTranslation("playerinfo.view.ThaneAttributeFrame.txt" + _loc4_);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeViewII.imageTxt" + (_loc4_ - 5));
            }
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _loc1_.setFrame(1);
            if(_loc4_ < 9)
            {
               _vBox5.addChild(_loc3_);
               _vBox6.addChild(_loc1_);
            }
            else
            {
               _vBox3.addChild(_loc2_);
               _vBox4.addChild(_loc1_);
            }
            _txtList.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _attNameList.length)
         {
            if(_loc1_ < 9)
            {
               _txtList[_loc1_].text = data.childAttInfo.resiArr[_loc1_];
            }
            else
            {
               _txtList[_loc1_].text = data.childAttInfo.attValueArr[_loc1_ - 9];
            }
            _loc1_++;
         }
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function cleanList() : void
      {
         if(_txtList)
         {
            while(_txtList.length > 0)
            {
               ObjectUtils.disposeObject(_txtList.pop());
            }
            _txtList = null;
         }
      }
      
      override public function dispose() : void
      {
         cleanList();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox3);
         _vBox3 = null;
         ObjectUtils.disposeObject(_vBox4);
         _vBox4 = null;
         ObjectUtils.disposeObject(_vBox5);
         _vBox5 = null;
         ObjectUtils.disposeObject(_vBox6);
         _vBox6 = null;
         ObjectUtils.disposeObject(_withAttri);
         _withAttri = null;
         ObjectUtils.disposeObject(_withAttriLine);
         _withAttriLine = null;
         _data = null;
         _attNameList = null;
         super.dispose();
      }
   }
}

