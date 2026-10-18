package theseusCollention.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollenTionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class TheseusBoxItem extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _selectBg:Bitmap;
      
      private var _data:GoodsInfo;
      
      private var _title:GradientText;
      
      private var _num:FilterFrameText;
      
      protected var _red:Bitmap;
      
      public function TheseusBoxItem(param1:int)
      {
         super();
         _id = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("theseusbox.icon");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.theseusCollection_boxSelect");
         _title = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameTxt11");
         _back.setFrame(_id + 1);
         _num = ComponentFactory.Instance.creatComponentByStylename("theseuscollectionBox.view.num");
         _red = ComponentFactory.Instance.creatBitmap("asset.theseusCollection.red1");
         addChild(_selectBg);
         addChild(_back);
         addChild(_title);
         _red.visible = false;
         addChild(_red);
         _red.y = 15;
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
         model.selectBox = data;
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(data)
         {
            _title.text = data.templateInfo.TemplateName;
            _selectBg.visible = data.templateInfo.TemplateId == model.selectBox.templateInfo.TemplateId;
            _num.text = data.count + "";
            _red.visible = data.count > 0;
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
         ObjectUtils.disposeObject(_red);
         _red = null;
         _data = null;
         super.dispose();
      }
   }
}

