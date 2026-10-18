package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   
   public class ChesspvpRecordGroupUI extends Sprite
   {
      
      protected var _tbg:Bitmap;
      
      protected var _rdGTTxt:FilterFrameText;
      
      protected var _rdVbox:VBox;
      
      protected var _itemList:Array = [];
      
      public function ChesspvpRecordGroupUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _tbg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rc.tbg");
         _rdGTTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdGTTxt");
         _rdVbox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.rd.childVbox");
         addChild(_tbg);
         addChild(_rdGTTxt);
         addChild(_rdVbox);
      }
      
      public function updateView(param1:int, param2:Array, param3:int) : void
      {
         var _loc4_:ChesspvpRecordUI = null;
         var _loc6_:int = 0;
         var _loc7_:String = LanguageMgr.GetTranslation("chesspvp.recored.timeType" + param3);
         _rdGTTxt.text = LanguageMgr.GetTranslation("chesspvp.recored.groupName" + param1,_loc7_);
         _rdVbox.beginChanges();
         var _loc5_:int = int(param2 ? param2.length : 0);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = new ChesspvpRecordUI();
            _loc4_.data = param2[_loc6_];
            _rdVbox.addChild(_loc4_);
            _itemList.push(_loc4_);
            _loc6_++;
         }
         _rdVbox.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_tbg);
         _tbg = null;
         ObjectUtils.disposeObject(_rdGTTxt);
         _rdGTTxt = null;
         ObjectUtils.disposeObject(_rdVbox);
         _rdVbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

