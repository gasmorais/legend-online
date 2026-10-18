package remainsexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.RemainsExploreTempInfo;
   import yishi.manager.RemainsExploreManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class RemainsExploreDropFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _dropTxt:FilterFrameText;
      
      private var _bossDropTxt1:FilterFrameText;
      
      private var _bossDropTxt2:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _bossHBox1:HBox;
      
      private var _bossHBox2:HBox;
      
      private const NUM:int = 3;
      
      public function RemainsExploreDropFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("remainsExploreDropFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreDropFrame.bg");
         _dropTxt = ComponentFactory.Instance.creatComponentByStylename("remainsExploreDropFrame.dropTxt");
         _bossDropTxt1 = ComponentFactory.Instance.creatComponentByStylename("remainsExploreDropFrame.bossDropTxt1");
         _bossDropTxt2 = ComponentFactory.Instance.creatComponentByStylename("remainsExploreDropFrame.bossDropTxt2");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("remainsExploreDropFrame.hBox");
         _bossHBox1 = ComponentFactory.Instance.creatComponentByStylename("remainsExploreDropFrame.bossHBox1");
         _bossHBox2 = ComponentFactory.Instance.creatComponentByStylename("remainsExploreDropFrame.bossHBox2");
         addToContent(_bg);
         addToContent(_dropTxt);
         addToContent(_bossDropTxt1);
         addToContent(_bossDropTxt2);
         addToContent(_hBox);
         addToContent(_bossHBox1);
         addToContent(_bossHBox2);
         _dropTxt.text = LanguageMgr.GetTranslation("remainsExploreDropFrame.dropTxt.text");
         _bossDropTxt1.text = LanguageMgr.GetTranslation("remainsExploreDropFrame.bossDropTxt1.text");
         _bossDropTxt2.text = LanguageMgr.GetTranslation("remainsExploreDropFrame.bossDropTxt2.text");
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function refreshView() : void
      {
         _hBox.removeAllChild();
         _bossHBox1.removeAllChild();
         _bossHBox2.removeAllChild();
         refreshItem();
      }
      
      private function refreshItem() : void
      {
         var _loc2_:SimpleDictionary = null;
         var _loc1_:RemainsExploreTempInfo = TempleteManager.instance.remainsExploreTempCate.getTempInfo(model.tempAreaId,model.tempNodeId);
         if(_loc1_)
         {
            _loc2_ = TempleteManager.instance.remainsExploreEventTempCate.getDrop(_loc1_.EventGroup);
            if(_loc2_)
            {
               refreshHBox([_loc2_[1]],_bossHBox1);
               refreshHBox([_loc2_[2]],_bossHBox2);
               refreshHBox(_loc2_[3],_hBox);
            }
         }
      }
      
      private function refreshHBox(param1:Array, param2:HBox) : void
      {
         var _loc7_:GoodsInfo = null;
         var _loc8_:CommonDropTempInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Array = TempleteManager.instance.remainsExploreDropTempCate.getInfoByArray(param1);
         if(_loc6_.length > 0)
         {
            _loc6_.sort(tempSort);
            _loc4_ = Math.min(3,_loc6_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc8_ = _loc6_[_loc5_];
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _loc8_.itemId;
               _loc3_ = ComponentFactory.Instance.creatCustomObject("remainsExploreDropFrame.itemView");
               _loc3_.data = _loc7_;
               param2.addChild(_loc3_);
               _loc5_++;
            }
         }
      }
      
      private function tempSort(param1:CommonDropTempInfo, param2:CommonDropTempInfo) : int
      {
         if(param1.appearType == 3)
         {
            if(param2.appearType == 3 && param1.itemId <= param2.itemId)
            {
               return -1;
            }
            return 1;
         }
         if(param1.itemId > param2.itemId)
         {
            return 1;
         }
         return -1;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_dropTxt);
         _dropTxt = null;
         ObjectUtils.disposeObject(_bossDropTxt1);
         _bossDropTxt1 = null;
         ObjectUtils.disposeObject(_bossDropTxt2);
         _bossDropTxt2 = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(_bossHBox1);
         _bossHBox1 = null;
         ObjectUtils.disposeAllChildren(_bossHBox2);
         _bossHBox2 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

