package theseusDoublepvpscene.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.TheseusMultiPvpTaskTempInfo;
   
   public class TheseusBoxItem extends Component implements IManualSize
   {
      
      private var _chest:ScaleFrameImage;
      
      private var _light:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _index:int;
      
      private const COUNT:int = 3;
      
      private var _bg:Bitmap;
      
      private var _data:TheseusDoublePvpRewardInfo = new TheseusDoublePvpRewardInfo();
      
      public function TheseusBoxItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         TheseusPvpManager.Instance.doSomething1(7,_data.templateId);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,207,52);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.Chestframe");
         _txt = ComponentFactory.Instance.creatComponentByStylename("theseuspvp.TheseusDoubleBoxItemTxt");
         _chest = ComponentFactory.Instance.creatComponentByStylename("skyStepItem.chest1");
         _light = ComponentFactory.Instance.creatBitmap("asset.skyStepItem.light");
         _light.y = _light.x = -15;
         addChild(_bg);
         _bg.visible = false;
         addChild(_light);
         addChild(_chest);
         addChild(_txt);
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "4,1,6,5,2,7,0,3";
         isFollowMouse = false;
      }
      
      public function get data() : TheseusDoublePvpRewardInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusDoublePvpRewardInfo) : void
      {
         _data = param1;
         var _loc2_:Array = [0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0];
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter(_loc2_);
         if(_data)
         {
            _chest.setFrame(_index + 1);
            _light.visible = false;
            switch(int(_data.state) - 1)
            {
               case 0:
                  _chest.filters = [];
                  _light.visible = true;
                  break;
               case 1:
                  _chest.filters = [_loc3_];
            }
         }
      }
      
      public function refreshView(param1:TheseusMultiPvpTaskTempInfo) : void
      {
         var _loc8_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Array = null;
         if(!param1)
         {
            return;
         }
         _txt.text = param1.TaskNum + "" + LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc6");
         data.templateId = param1.Id;
         var _loc4_:int = 0;
         var _loc6_:Object = {};
         var _loc3_:Array = [];
         var _loc7_:Array = param1.Reward.split("|");
         if(_loc7_.length > 0)
         {
            _loc7_.sortOn("id",16);
            _loc4_ = Math.min(3,_loc7_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = _loc7_[_loc5_].split(",");
               _loc8_ = new GoodsInfo();
               _loc8_.templateId = int(_loc2_[0]);
               _loc8_.count = int(_loc2_[1]);
               _loc3_.push(_loc8_);
               _loc5_++;
            }
            _loc6_.name = param1.Name;
            _loc6_.arr = _loc3_;
            _chest.tipData = _loc6_;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_chest);
         _chest = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

