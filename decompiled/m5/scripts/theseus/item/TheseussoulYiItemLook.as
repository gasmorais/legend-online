package theseus.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.templates.TheseusRageTempInfo;
   
   public class TheseussoulYiItemLook extends Sprite
   {
      
      public var _yiStrengBox1:VBox;
      
      public var _yiStrengBox2:VBox;
      
      private var _titleList:Array = [];
      
      private var _valueList:Array = [];
      
      private var _type:int;
      
      public function TheseussoulYiItemLook(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _yiStrengBox1 = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.yiStrengBox1");
         _yiStrengBox2 = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.yiStrengBox2");
         addChild(_yiStrengBox1);
         addChild(_yiStrengBox2);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _titleList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _titleList = null;
         for each(_loc1_ in _valueList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _valueList = null;
         ObjectUtils.disposeObject(_yiStrengBox1);
         _yiStrengBox1 = null;
         ObjectUtils.disposeObject(_yiStrengBox2);
         _yiStrengBox2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set dataList(param1:Array) : void
      {
         var _loc4_:Array = null;
         var _loc7_:String = null;
         var _loc6_:int = 0;
         var _loc3_:FilterFrameText = null;
         var _loc2_:Dictionary = null;
         var _loc8_:Dictionary = null;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc5_:TheseusRageTempInfo = param1.shift();
         _yiStrengBox1.removeAllChild();
         _yiStrengBox2.removeAllChild();
         if(_loc5_)
         {
            _loc4_ = _loc5_.attDic.keys;
            _loc6_ = 0;
            _loc2_ = new Dictionary();
            _yiStrengBox1.beginChanges();
            _yiStrengBox2.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_ = _titleList[_loc6_];
               if(_loc3_ == null)
               {
                  _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.yiStrengTxt1");
                  _titleList[_loc6_] = _loc3_;
               }
               _loc7_ = _loc4_[_loc6_];
               _loc3_.text = _loc7_ + ":";
               _yiStrengBox1.addChild(_loc3_);
               _loc3_ = _valueList[_loc6_];
               if(_loc3_ == null)
               {
                  _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.yiStrengTxt2");
                  _valueList[_loc6_] = _loc3_;
               }
               _loc3_.setFrame(_type);
               _loc3_.text = "" + _loc5_.attDic[_loc7_];
               _yiStrengBox2.addChild(_loc3_);
               _loc2_[_loc4_[_loc6_]] = _loc3_;
               _loc6_++;
            }
            _yiStrengBox1.commitChanges();
            _yiStrengBox2.commitChanges();
            _loc8_ = new Dictionary();
            for each(_loc5_ in param1)
            {
               _loc4_ = _loc5_.attDic.keys;
               for each(_loc7_ in _loc4_)
               {
                  if(!_loc8_[_loc7_])
                  {
                     _loc8_[_loc7_] = 0;
                  }
                  var _loc9_:String = _loc7_;
                  var _loc10_:Number = _loc8_[_loc9_] + _loc5_.attDic[_loc7_];
                  _loc8_[_loc9_] = _loc10_;
               }
            }
            for(_loc7_ in _loc8_)
            {
               _loc3_ = _loc2_[_loc7_];
               if(_loc3_)
               {
                  _loc3_.htmlText = LanguageMgr.GetTranslation("theseus.war.zhanyiAddValue",_loc3_.text,_loc8_[_loc7_]);
               }
            }
         }
      }
   }
}

