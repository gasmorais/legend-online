package battle.chat
{
   import battle.BattleManager;
   import chat.ChatManager;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import chat.view.ExpressionChatNotic;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class BattleChatPopView extends Component
   {
      
      private var _name:FilterFrameText;
      
      private var _iconBack:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _back:Bitmap;
      
      private var _chatTxt:ExpressionChatNotic;
      
      private var _callBack:Function;
      
      private var _timeId:int;
      
      public function BattleChatPopView(param1:Function)
      {
         super();
         _callBack = param1;
         initView();
      }
      
      private function initView() : void
      {
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.battle.ChatPopIconBack");
         _back = ComponentFactory.Instance.creatBitmap("asset.battle.ChatPopAsset");
         _name = ComponentFactory.Instance.creatComponentByStylename("battle.ChatPopName");
         _icon = ComponentFactory.Instance.creatCustomObject("battle.ChatPopIcon");
         _chatTxt = new ExpressionChatNotic();
         _chatTxt.x = 54;
         _chatTxt.y = 24;
         _chatTxt.lineWidth = 125;
         addChild(_back);
         addChild(_icon);
         addChild(_iconBack);
         _icon.mask = creatShape();
         addChild(_name);
         addChild(_chatTxt);
         mouseChildren = mouseEnabled = false;
      }
      
      private function creatShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(0,0,23);
         _loc1_.graphics.endFill();
         _loc1_.x = 26;
         _loc1_.y = 25;
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function set data(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc5_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         ObjectUtils.copyProperties(_loc5_,param1["data"],true);
         var _loc4_:int = 44;
         var _loc3_:int = _loc5_.getNormalMsg().length;
         var _loc2_:String = StringHelper.substr(_loc5_.getNormalMsg(),_loc4_);
         var _loc6_:int = _loc2_.lastIndexOf("[");
         var _loc7_:int = _loc2_.lastIndexOf("]");
         if(_loc6_ > _loc7_)
         {
            _loc2_ = _loc5_.msg.substr(0,_loc6_);
         }
         if(_loc3_ > _loc2_.length)
         {
            _loc2_ += "......";
         }
         _loc5_.msg = ChatManager.instance.analyzeExpressionAfterNormal(_loc2_);
         _loc5_.channel = 8;
         _loc5_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc5_);
         _chatTxt.needFilters = true;
         _chatTxt.data = _loc5_;
         _name.text = LanguageMgr.GetTranslation("public.colon",_loc5_.senderName);
         if(battleModel.battleType != 3866 && battleModel.battleType != 3864)
         {
            _icon.icon = IconFactory.getPlayerIcon(int(param1["id"]),"head");
         }
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         _timeId = setTimeout(close,5000);
      }
      
      private function close() : void
      {
         dispose();
         if(_callBack != null)
         {
            _callBack();
         }
         _callBack = null;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      override public function dispose() : void
      {
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_chatTxt);
         _chatTxt = null;
         super.dispose();
      }
   }
}

