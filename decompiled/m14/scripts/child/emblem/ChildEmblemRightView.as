package child.emblem
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   
   public class ChildEmblemRightView extends Frame
   {
      
      private var _vBox1:VBox;
      
      private var _vBox2:VBox;
      
      private var _vBox3:VBox;
      
      private var _vBox4:VBox;
      
      private var _txtList:Vector.<FilterFrameText>;
      
      private var _data:ChildData;
      
      private var _goodsList:Vector.<GoodsInfo>;
      
      private var _attNameList:Array;
      
      private var _gap:Image;
      
      private var _delay:uint;
      
      public function ChildEmblemRightView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _attNameList = ["Emblem1","Emblem2","Emblem3","Emblem4","Emblem5","Emblem6","Emblem7","Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("child.emblem.ChildEmblemRightView.titleTxt");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemRightView.vBox1");
         _vBox2 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemRightView.vBox2");
         _vBox3 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemRightView.vBox3");
         _vBox4 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemRightView.vBox4");
         _gap = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.gap");
         _txtList = new Vector.<FilterFrameText>();
         _goodsList = new Vector.<GoodsInfo>();
         addToContent(_vBox1);
         addToContent(_vBox2);
         addToContent(_vBox3);
         addToContent(_vBox4);
         addToContent(_gap);
         addImageAndTxt();
      }
      
      private function addImageAndTxt() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         var _loc1_:FilterFrameText = null;
         _loc3_ = 0;
         while(_loc3_ < _attNameList.length)
         {
            if(_loc3_ < 7)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.ChildEmblemRightView.Img" + _loc3_);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeViewII.imageTxt" + (_loc3_ - 3));
            }
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            if(_loc3_ < 7)
            {
               _vBox1.addChild(_loc2_);
               _vBox2.addChild(_loc1_);
               _loc1_.setFrame(1);
            }
            else
            {
               _vBox3.addChild(_loc2_);
               _vBox4.addChild(_loc1_);
               _loc1_.setFrame(2);
            }
            _txtList.push(_loc1_);
            _loc3_++;
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
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         if(_attNameList)
         {
            _loc1_ = 0;
            while(_loc1_ < _attNameList.length)
            {
               if(_loc1_ < 7)
               {
                  _txtList[_loc1_].text = data.childAttInfo.resiArr[_loc1_];
               }
               else
               {
                  _txtList[_loc1_].text = data.childAttInfo.attValueArr[_loc1_ - 7];
               }
               _loc1_++;
            }
         }
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
         removeEvent();
         cleanList();
         if(_vBox1)
         {
            ObjectUtils.disposeObject(_vBox1);
         }
         _vBox1 = null;
         if(_vBox2)
         {
            ObjectUtils.disposeObject(_vBox2);
         }
         _vBox2 = null;
         if(_vBox3)
         {
            ObjectUtils.disposeObject(_vBox3);
         }
         _vBox3 = null;
         if(_vBox4)
         {
            ObjectUtils.disposeObject(_vBox4);
         }
         _vBox4 = null;
         LogicUtils.disposeDisplayCollection(_goodsList);
         _goodsList = null;
         if(_gap)
         {
            ObjectUtils.disposeObject(_gap);
         }
         _gap = null;
         _data = null;
         _attNameList = null;
         super.dispose();
      }
   }
}

