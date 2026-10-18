package sqmemory
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SqmemoryRewardFrame extends Frame
   {
      
      private var _confirmBtn:IconButton;
      
      private var _titleList:SimpleTileList;
      
      public function SqmemoryRewardFrame()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.reward.confirmBtn");
         _titleList = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.reward.list",[4]);
         addToContent(_titleList);
         addToContent(_confirmBtn);
      }
      
      private function initData() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("anniversary_review_reward");
         var _loc5_:Array = _loc2_.ConfigValue.split("|");
         _titleList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc6_ = _loc5_[_loc3_];
            _loc7_ = _loc6_.split(",");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = int(_loc7_[0]);
            _loc4_.count = int(_loc7_[1]);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc1_.data = _loc4_;
            _titleList.addChild(_loc1_);
            _loc3_++;
         }
         _titleList.commitChanges();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",confirmHandler);
      }
      
      private function confirmHandler(param1:MouseEvent) : void
      {
         dispose();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_titleList);
         ObjectUtils.disposeObject(_titleList);
         _titleList = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("public.prompt");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

