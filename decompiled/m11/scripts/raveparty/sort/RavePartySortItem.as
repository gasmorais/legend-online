package raveparty.sort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.raveparty.RavePartySortInfo;
   
   public class RavePartySortItem extends Component
   {
      
      private var overBg:Scale9CornerImage;
      
      private var orderText:FilterFrameText;
      
      private var guildNameText:FilterFrameText;
      
      private var serverNameText:FilterFrameText;
      
      private var scoreText:FilterFrameText;
      
      private var lineImage:Image;
      
      private var _sortType:int;
      
      private var _data:RavePartySortInfo;
      
      public function RavePartySortItem(param1:int)
      {
         super();
         _sortType = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         overBg = ComponentFactory.Instance.creatComponentByStylename("RavePartySortItem.overBg");
         orderText = ComponentFactory.Instance.creatComponentByStylename("RavePartySortItem.orderText");
         guildNameText = ComponentFactory.Instance.creatComponentByStylename("RavePartySortItem.guildNameText");
         serverNameText = ComponentFactory.Instance.creatComponentByStylename("RavePartySortItem.serverNameText");
         scoreText = ComponentFactory.Instance.creatComponentByStylename("RavePartySortItem.scoreText");
         lineImage = ComponentFactory.Instance.creatComponentByStylename("RavePartySortItem.lineImage");
         addChild(overBg);
         addChild(orderText);
         addChild(guildNameText);
         addChild(serverNameText);
         addChild(scoreText);
         overBg.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__mouseOverHandler);
         addEventListener("rollOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__mouseOverHandler);
         removeEventListener("rollOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            overBg.visible = true;
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         overBg.visible = false;
      }
      
      public function get data() : RavePartySortInfo
      {
         return _data;
      }
      
      public function set data(param1:RavePartySortInfo) : void
      {
         clean();
         _data = param1;
         if(data)
         {
            orderText.text = _data.order + "";
            serverNameText.text = _data.serverName;
            scoreText.text = _data.score + "";
            if(_sortType == 7)
            {
               guildNameText.text = _data.guildName;
               serverNameText.setFrame(2);
               serverNameText.x = 235;
            }
            else
            {
               serverNameText.setFrame(1);
               serverNameText.x = 165;
            }
         }
      }
      
      private function clean() : void
      {
         orderText.text = "";
         guildNameText.text = "";
         serverNameText.text = "";
         scoreText.text = "";
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(overBg)
         {
            ObjectUtils.disposeObject(overBg);
         }
         overBg = null;
         if(orderText)
         {
            ObjectUtils.disposeObject(orderText);
         }
         orderText = null;
         if(guildNameText)
         {
            ObjectUtils.disposeObject(guildNameText);
         }
         guildNameText = null;
         if(serverNameText)
         {
            ObjectUtils.disposeObject(serverNameText);
         }
         serverNameText = null;
         if(scoreText)
         {
            ObjectUtils.disposeObject(scoreText);
         }
         scoreText = null;
         if(lineImage)
         {
            ObjectUtils.disposeObject(lineImage);
         }
         lineImage = null;
         super.dispose();
      }
   }
}

