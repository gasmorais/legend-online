package hook
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hook.view.HookItem;
   import manager.LanguageMgr;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.TempleteManager;
   
   public class HookFrame extends Frame
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Scale9CornerImage;
      
      private var _titleBack:Bitmap;
      
      private var _rewardBtn:IconButton;
      
      private var _listContain:Sprite;
      
      private var _roomDic:Dictionary;
      
      public function HookFrame()
      {
         super();
         initView();
         initRoom();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("hook.FrameBack1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("hook.FrameBack2");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.hook.TitleBack");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("hook.RewardBtn");
         _listContain = new Sprite();
         _listContain.x = 13;
         _listContain.y = 66;
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_titleBack);
         addToContent(_listContain);
         titleText = LanguageMgr.GetTranslation("hook.HookFrame.title");
      }
      
      private function initRoom() : void
      {
         var _loc5_:int = 0;
         var _loc2_:CampaignTemplate = null;
         var _loc3_:HookItem = null;
         _roomDic = new Dictionary();
         var _loc4_:Dictionary = TempleteManager.instance.worldBossTemplateDict;
         var _loc1_:Array = [];
         for each(var _loc6_:CampaignTemplate in _loc4_)
         {
            if(_loc6_.Types == 3)
            {
               _loc1_.push(_loc6_);
            }
         }
         _loc1_.sort();
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc5_] as CampaignTemplate;
            _loc3_ = new HookItem();
            _loc3_.temp = _loc2_;
            _roomDic[_loc2_.CampaignId] = _loc3_;
            _loc3_.x = _loc5_ % 3 * _loc3_.width;
            _loc3_.y = int(_loc5_ / 3) * _loc3_.height;
            _listContain.addChild(_loc3_);
            _loc5_++;
         }
         if(_loc5_ < 8)
         {
            _loc5_;
            while(_loc5_ < 9)
            {
               _loc3_ = new HookItem();
               _loc3_.temp = null;
               _loc3_.x = _loc5_ % 3 * _loc3_.width;
               _loc3_.y = int(_loc5_ / 3) * _loc3_.height;
               _listContain.addChild(_loc3_);
               _loc5_++;
            }
         }
      }
      
      public function getRoomItem(param1:int) : HookItem
      {
         return _roomDic[param1];
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _rewardBtn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _rewardBtn.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false);
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
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_listContain);
         _listContain = null;
         for each(var _loc1_:HookItem in _roomDic)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         super.dispose();
      }
   }
}

